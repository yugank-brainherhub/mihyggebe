# frozen_string_literal: true

class Role < ApplicationRecord
  PROVIDER = 'provider'
  ADMIN    = 'admin'

  # validations
  validates :name, presence: true, uniqueness: true
  # Associations
  has_many :users

  class << self
    def provider
      find_by(name: PROVIDER)
    end

    def admin
      find_by(name: ADMIN)
    end
  end
end
