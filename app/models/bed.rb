# frozen_string_literal: true

class Bed < ApplicationRecord
  enum bed_type: %i[king queen twin hospital]
  validates :bed_number, length: { minimum: 1, maximum: 10 }
  validates_uniqueness_of :bed_number, scope: [:room_id]
  validate_enum_attributes :bed_type

  # Association
  belongs_to :room, counter_cache: true
  belongs_to :service
  has_many :bed_bookings, dependent: :destroy
  has_many :bookings, through: :bed_bookings

  scope :bookings_not_in_range, lambda { |from, to|
    where.not(
      '(:start_date >= bookings.checkin AND bookings.checkin <= :end_date) OR
      (:start_date >= bookings.checkout AND bookings.checkout <= :end_date) OR
      (:start_date >= bookings.checkin AND bookings.checkout <= :end_date)',
      start_date: from,
      end_date: to
    )
  }

  scope :bookings_in_range, lambda { |from, to|
    where(
      '(:start_date >= bookings.checkin AND bookings.checkin <= :end_date) OR
      (:start_date >= bookings.checkout AND bookings.checkout <= :end_date) OR
      (:start_date >= bookings.checkin AND bookings.checkout <= :end_date)',
      start_date: from,
      end_date: to
    )
  }

  scope :booked_beds_count,lambda { |from, to|
    joins(:bookings).bookings_in_range(from, to).distinct.count
  }
end
