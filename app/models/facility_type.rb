# frozen_string_literal: true

class FacilityType < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
  has_many :facilities, dependent: :destroy
end
