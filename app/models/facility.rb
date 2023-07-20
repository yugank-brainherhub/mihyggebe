# frozen_string_literal: true

class Facility < ApplicationRecord
  # Validations
  validates_uniqueness_of :name, scope: [:facility_type_id]
  has_many :selected_facilities, dependent: :destroy
  belongs_to :facility_type
end
