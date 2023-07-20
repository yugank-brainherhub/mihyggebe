# frozen_string_literal: true

class SelectedRoom < ApplicationRecord
  # validation
  validates_uniqueness_of :room_type_id, scope: [:care_id]
  # Asscoiation
  belongs_to :care
  belongs_to :room_type
end
