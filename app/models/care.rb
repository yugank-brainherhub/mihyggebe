# frozen_string_literal: true

class Care < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_by_country,
                  against: :country,
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_county,
                  against: :county,
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_state,
                  against: :state,
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_city,
                  against: :city,
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_services_and_facilities,
                  associated_against: {
                    room_types: :name,
                    facility_types: :name,
                    facilities: :name,
                    service_types: :name,
                    services: :name
                  }


  enum category: %i[home_share senior_living]
  enum status: %i[draft pending in-progress active rejected cancelled]

  # Validations
  validates :address1, :zipcode, :state, :country, :county, :category, presence: true
  validates :board_members, presence: true, on: :update,
    if: -> { category == 'senior_living' && pending? }
  validates :state, :county, :city, length: { minimum: 3, maximum: 20 }
  validates :state, :city, format: { with: /^[a-zA-Z ]*$/,
                                     multiline: true,
                                     message: I18n.t('user.name_error') }
  validates :country, format: { with: /^[a-zA-Z ]*$/,
                                multiline: true,
                                message: I18n.t('user.name_error') }
  validates :zipcode, numericality: true
  validates :name, length: { minimum: 5, maximum: 30 }
  validates :address1, length: { minimum: 6, maximum: 50 }

  validate_enum_attributes :category, :status

  # Scopes
  scope :filterby_location, lambda { |query|
                              where("state ILIKE '%#{query}%' OR
                     county ILIKE '%#{query}%' OR
                     country ILIKE '%#{query}%' OR
                     address2 ILIKE '%#{query}%' OR
                     zipcode ILIKE '%#{query}%'")
                            }
  scope :filterby_category, lambda { |category|
                              where(category: category)
                            }

  scope :filterby_service, lambda { |query|
                             "SELECT cs.id
                              FROM cares cs
                              LEFT OUTER JOIN selected_services ss ON ss.care_id = cs.id
                              INNER JOIN services s ON ss.service_id = s.id
                              LEFT OUTER JOIN selected_rooms sr ON sr.care_id = cs.id
                              INNER JOIN room_types rt ON sr.room_type_id =  rt.id
                              LEFT OUTER JOIN selected_facilities sf ON sf.care_id = cs.id
                              INNER JOIN facilities f ON sf.facility_id = f.id
                              INNER JOIN facility_types ft ON ft.id = sf.facility_type_id
                              INNER JOIN service_types st ON st.id  = ss.service_type_id
                              WHERE (s.name ILIKE '%#{query}%' OR
                              st.name ILIKE '%#{query}%' OR
                              rt.name ILIKE '%#{query}%' OR
                              f.name ILIKE '%#{query}%' OR
                              ft.name ILIKE '%#{query}%')"
                     }

  scope :filterby_licence, lambda { |licence_types|
                             includes(:licences).where(licences: { licence_type: licence_types })
                                                .references(:licences)
                           }
  scope :filterby_bedtype, lambda { |bed_types|
                             where(beds: { bed_type: bed_types })
                           }

  scope :filterby_roomtype, lambda { |room_types|
                              where(rooms: { room_type: room_types })
                            }
  scope :filterby_price, lambda { |max, min|
                           where('rooms.price >= ? AND rooms.price <= ?', min, max)
                         }
  scope :filterby_distance, lambda { |distance|
                              where('approx_distance <= ?', distance)
                            }
  # Associations
  belongs_to :user
  with_options dependent: :destroy do
    has_one  :subscription
    has_many :rooms
    has_many :beds, through: :rooms
    has_many :bookings
    has_many :licences
    has_many :staff_details
    has_many :assets, as: :assetable
    has_one  :care_detail
    has_many :selected_rooms
    has_many :room_types, -> { distinct }, through: :selected_rooms
    has_many :selected_services
    has_many :services, -> { distinct }, through: :selected_services
    has_many :service_types, -> { distinct }, through: :selected_services
    has_many :selected_facilities
    has_many :facilities, -> { distinct }, through: :selected_facilities
    has_many :facility_types,  -> { distinct }, through: :selected_facilities
    has_many :comments, as: :resource
    has_many :wishlists
    has_many :wl_users, :through => :wishlists, :source => :user
  end

  accepts_nested_attributes_for :care_detail, :licences, :selected_rooms, :staff_details,
                                :selected_services, :selected_facilities, allow_destroy: true

  after_commit :geolocate_address, on: %i[create update]

  def geolocate_address
    changeset_keys = previous_changes.keys

    unless (changeset_keys & %w[address1 address2 address3 county state city zipcode country]).any?
      return
    end

    GeolocationJob.perform_later(id)
  end

  def staff_details_attributes=(*attrs)
    staff_details.clear
    super(*attrs)
  end

  def selected_rooms_attributes=(*attrs)
    selected_rooms.clear
    super(*attrs)
  end


  def selected_services_attributes=(*attrs)
    selected_services.clear
    super(*attrs)
  end

  def selected_facilities_attributes=(*attrs)
    selected_facilities.clear
    super(*attrs)
  end

  def cancel_care(care_id)
    unsubscribe(care_id)
    create_refund_and_save_status(care_id)
  rescue StandardError => e
    { error: e.message }
  end

  def calculate_amount_to_refund(subscription)
    invoice_id = Stripe::Subscription.retrieve(subscription.subscriptionId).latest_invoice
    invoice = Stripe::Invoice.retrieve(invoice_id)
    invoice.total - invoice.tax
  end

  def create_refund_and_save_status(care_id)
    care = Care.find(care_id)
    unless care.active?
      subscription = Subscription.find_by(care: care)
      amount_to_refund = calculate_amount_to_refund(subscription)

      refund = create_refund(amount_to_refund, subscription.payment_intent)
      return refund if refund[:error].present?

      subscription.create_subscription_refunds(description: refund.payment_intent,
                                              refundId: refund.id,
                                              status: refund.status)
    end
  end

  def create_refund(amount_to_refund, payment_intent)
    Stripe::Refund.create(amount: amount_to_refund, payment_intent: payment_intent)
  end

  def unsubscribe(care_id)
    subscription = Care.find_by(id: care_id).subscription
    Stripe::Subscription.delete(subscription.subscriptionId) if subscription.present?
  end

  def find_subscription(id)
    Subscription.find_by(care_id: id)
  end

  def self.care_search(query)
    @search = Care.search(query)
    return @search.result
  end

end
