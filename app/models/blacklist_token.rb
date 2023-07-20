# frozen_string_literal: true

class BlacklistToken < ApplicationRecord
  validates :token, presence: true
end
