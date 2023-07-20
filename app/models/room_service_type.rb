# frozen_string_literal: true

class RoomServiceType < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  # Association
  has_many :room_services, dependent: :destroy
end
