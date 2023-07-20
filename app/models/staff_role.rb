# frozen_string_literal: true

class StaffRole < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  # Association
  has_many :staff_details
end
