# frozen_string_literal: true

class SelectedRoomService < ApplicationRecord
  # validation
  validates_uniqueness_of :room_service_id, scope: [:room_id]
  # Association
  belongs_to :room
  belongs_to :room_service_type
  belongs_to :room_service
end
