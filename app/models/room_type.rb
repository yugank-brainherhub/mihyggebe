# frozen_string_literal: true

class RoomType < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
end
