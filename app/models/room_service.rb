# frozen_string_literal: true

class RoomService < ApplicationRecord
  # validations
  validates_uniqueness_of :name, scope: [:room_service_type_id]
  has_many :selected_room_services, dependent: :destroy
  belongs_to :room_service_type
end
