# frozen_string_literal: true

class CareDetail < ApplicationRecord
  # Association
  belongs_to :care

  def self.cares_ready_for_subscription(current_user)
    includes(:care).where(cares: { user: current_user, status: 'pending' }).map { |detail| detail }
  end
end
