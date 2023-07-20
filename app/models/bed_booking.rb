# frozen_string_literal: true

class BedBooking < ApplicationRecord
  # Association
  belongs_to :bed
  belongs_to :booking
end
