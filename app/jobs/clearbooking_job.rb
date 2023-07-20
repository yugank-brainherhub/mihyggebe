# frozen_string_literal: true

class ClearbookingJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    booking = Booking.find_by(id: booking_id)
    blocked_beds = booking.beds.ids.collect(&:to_s)

    if booking.present? && booking.draft?
      booking.update_columns(status: 'cancelled')
      Room.reset_blocked_beds(blocked_beds)
    end
  end
end
