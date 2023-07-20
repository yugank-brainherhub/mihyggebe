# frozen_string_literal: true

class Service < ApplicationRecord
  # Validations
  validates_uniqueness_of :name, scope: [:service_type_id]
  # Association
  has_many :selected_services, dependent: :destroy
  has_many :beds, dependent: :destroy
  belongs_to :service_type
end
