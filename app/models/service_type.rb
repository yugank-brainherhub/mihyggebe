# frozen_string_literal: true

class ServiceType < ApplicationRecord
  enum available_for: %i[homeshare senior_living all_care_types]

  # Validations
  validates_uniqueness_of :name, scope: [:available_for]
  validate_enum_attributes :available_for

  # Association
  has_many :services, dependent: :destroy
  has_many :selected_services, dependent: :destroy
end
