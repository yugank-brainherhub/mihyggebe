# frozen_string_literal: true

class Booking < ApplicationRecord

  enum status: %i[draft pending accepted rejected cancelled terminated closed]

  # Validations
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, length: { minimum: 3, maximum: 60 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :mobile, presence: true
  validates_length_of :mobile, maximum: 13, numericality: true
  validates :checkin, :checkout, presence: true
  after_create_commit :set_booking
  before_create :verify_booking_dates

  # Association
  belongs_to :care
  belongs_to :user
  has_and_belongs_to_many :relationships
  has_many :bed_bookings, dependent: :destroy
  has_many :beds, -> { distinct }, through: :bed_bookings
  validates :bed_bookings, presence: true
  has_one :payment
  has_one :transfer, dependent: :destroy
  has_one :refund, dependent: :destroy

  accepts_nested_attributes_for :bed_bookings
  # validate_enum_attributes :status

  validate :validate_checkin_checkout, on: :create

  has_many :assets, as: :assetable

  #scopes
  scope :active, -> { where('(checkin >= ? OR checkout >= ?) AND status IN (?)', Date.today, Date.today, [::Booking.statuses['pending'], ::Booking.statuses['accepted']]) }
  scope :past, -> { where('checkin < ? AND checkout < ? AND status = ?', Date.today, Date.today, ::Booking.statuses['accepted']) }
  scope :cancelled, -> { where(status: ['cancelled', 'rejected', 'terminated']) }
  scope :filter_by_category, -> (category) { where('cares.category = ?', ::Care.categories[category]).references(:cares) }
  scope :filter_by_bookingId, -> (bookingID) { where(bookingID: bookingID.to_s) }
  scope :provider_bookings, -> (provider) { includes(:care, :beds, :user).where(care_id: provider.cares.pluck(:id)) }
  scope :customer_bookings, -> (customer) { includes(:care, :beds, :user).where(user_id: customer.id).where('bookings.status NOT IN (?)', ::Booking.statuses['draft'])}
  scope :valid_provider_booking_status, -> { where(status: booking_status_provider) }
  scope :filter_by_status, -> (status) { where(status: status) }
  scope :bookings_in_range, lambda { |from, to|
                                  where(
                                    '(bookings.checkin >= :start_date AND bookings.checkin <= :end_date) OR
                                    (bookings.checkout >= :start_date AND bookings.checkout <= :end_date)',
                                    start_date: from,
                                    end_date: to
                                  ).where("bookings.status IN (?)", [::Booking.statuses['pending'], ::Booking.statuses['accepted']])
                                }

  def verify_booking_dates
    !Booking.bookings_in_range(checkin, checkout).joins(:beds).where('beds.id IN (?)', beds.ids).exists?
  end

  def self.booking_status_provider
    %w[pending accepted rejected terminated]
  end

  def set_booking
  	self.bookingID = 10000 + self.id
  	self.save
  end

  def validate_checkin_checkout
    if checkin.present? && checkin.to_date < Date.today
      errors.add(:checkin, I18n.t('room.invalid_date'))
    end
    if checkout.present? && (checkout.to_date < Date.today || checkout.to_date < checkin.to_date)
      errors.add(:checkout, I18n.t('booking.checkout_error'))
    end
  end

  def calculate_percent(value, percent)
    ans = (value * percent).to_f / 100
    return ans.round if ans < ans.round

    ans.round(2)
  end
end
