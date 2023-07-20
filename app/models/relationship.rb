class Relationship < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
  # Associations
  has_and_belongs_to_many :bookings
end
