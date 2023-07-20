# frozen_string_literal: true

class Room < ApplicationRecord
  enum room_type: { "single" => 1,  "double" => 2,  "for-three" => 3,  "for-four" =>  4 }
  enum bathroom_type: %i[attached common]

  # validations
  validate_enum_attributes :room_type, :bathroom_type
  validates :name, :available_from, :available_to, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true
  validates_uniqueness_of :name, scope: %i[care_id]

  # Association
  belongs_to :care
  with_options dependent: :destroy do
    has_many :selected_room_services
    has_many :beds
    has_many :room_services, through: :selected_room_services
    has_many :assets, as: :assetable
  end
  has_many :bed_bookings, through: :beds
  has_many :bookings, through: :beds

  validate :validate_available_to

  validate :check_room, on: :update
  validate :validate_room, on: :create

  accepts_nested_attributes_for :selected_room_services, :beds, allow_destroy: true

  scope :available_beds, ->(beds_count, care_id) { where('rooms.beds_count >= ? AND rooms.care_id = ?', beds_count, care_id) }
  scope :unblocked_beds, ->(beds) { where.not(beds: { id: beds }) }
  scope :availabe_in_range, ->(from, to) { where('rooms.available_from <= ? AND rooms.available_to >= ?', from, to) }
  scope :bookings_not_in_range, lambda { |from, to|
                                  where.not(
                                    '(:start_date >= bookings.checkin AND bookings.checkin <= :end_date) OR
                                    (:start_date >= bookings.checkout AND bookings.checkout <= :end_date) OR
                                    (:start_date >= bookings.checkin AND bookings.checkout <= :end_date)',
                                    start_date: from,
                                    end_date: to
                                  )
                                }

  scope :filter_booked_rooms, ->(booked_rooms) { where(id: booked_rooms) }

  def any_active_bookings
    active = Room.includes(beds: [bed_bookings: :bookings])
        .joins('LEFT JOIN beds ON beds.room_id = rooms.id
               LEFT JOIN bed_bookings ON beds.id = bed_bookings.bed_id
               LEFT JOIN bookings ON bookings.id = bed_bookings.booking_id')
        .where('(bookings.checkin >= ? OR bookings.checkout >= ?) AND
               bookings.status IN (?) AND rooms.id = ?',
               Date.today, Date.today, [::Booking.statuses[:accepted], ::Booking.statuses[:pending]], self.id).count
    active > 0
  end

  class << self
    def blocked_beds
      bed_data = $redis.get('blocked_beds')
      bed_data.present? ? bed_data.split(',') : []
    end

    def reset_blocked_beds(beds = [])
      remaining_beds = Room.blocked_beds - beds
      $redis.set("blocked_beds", remaining_beds.join(','))
    end

    def blocked_beds_count_with_rooms
      ::Bed.where(id: blocked_beds).group(:room_id).count
    end

    def current_availability(rooms = [], from, to)
      blocked_count = blocked_beds_count_with_rooms

      # FIXME: Firing multiple queries. Need to find out better way to join tables.
      available_rooms = Room.availabe_in_range(from, to).where(id: rooms)
      booked_beds_count_with_rooms = BedBooking.select('distinct bed_id')
                                               .where(booking_id: Booking.bookings_in_range(from, to).ids,
                                                      bed_id: Bed.where(room_id: rooms))
                                        .joins(bed: :room)
                                        .group('rooms.id').count

      available_rooms.pluck(:id, :beds_count).to_h.each_with_object({}) do |(room_id, total_bed_count), hsh|
        hsh[room_id] = total_bed_count - booked_beds_count_with_rooms[room_id].to_i - blocked_count[room_id].to_i
      end
    end
  end

  private

  def validate_room
    if beds.size > Room.room_types[self.room_type]
      errors.add(:beds, I18n.t('room.invalid_beds'))
    end
    if available_from.present? && available_from.to_date < Date.today
      errors.add(:available_from, I18n.t('room.invalid_date'))
    end
    if care.care_detail.present? && care&.care_detail&.no_of_rooms <= care.rooms.count
      errors.add(:rooms, I18n.t('room.room_not_allowed'))
    end
  end

  def validate_available_to
    if available_to.present? &&
       (available_to.to_date < Date.today || available_to.to_date < available_from.to_date)
      errors.add(:available_to, "Can't be less than today's date and available_from")
    end
  end

  def check_room
    if any_active_bookings
      if available_to_changed? && self.available_to < self.available_to_was
        errors.add(:available_to, I18n.t('room.invalid_available_to'))
      end
      errors.add(:available_from, I18n.t('room.invalid_available_from')) if available_from_changed?
      errors.add(:price, I18n.t('room.invalid_price_includes')) if price_changed?
      errors.add(:price_desc, I18n.t('room.invalid_price_includes')) if price_desc_changed?
      errors.add(:beds, I18n.t('room.bed_error')) if self.beds.reject{|bed| bed.id.nil?}.any?(&:changed?)
    end
  end

end
