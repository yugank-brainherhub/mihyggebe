class Wishlist < ApplicationRecord

  # validation
  validates_uniqueness_of :care_id, scope: [:user_id]
  # Asscoiation
  belongs_to :care
  belongs_to :user
end
