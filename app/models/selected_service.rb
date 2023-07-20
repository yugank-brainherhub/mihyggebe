# frozen_string_literal: true

class SelectedService < ApplicationRecord
  # validation
  validates_uniqueness_of :service_id, scope: [:care_id]
  # Association
  belongs_to :care
  belongs_to :service_type
  belongs_to :service
end
