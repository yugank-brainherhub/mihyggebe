# frozen_string_literal: true

class SelectedFacility < ApplicationRecord
  # validation
  validates_uniqueness_of :facility_id, scope: [:care_id]
  # Association
  belongs_to :care
  belongs_to :facility_type
  belongs_to :facility
end
