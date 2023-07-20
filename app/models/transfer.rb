# frozen_string_literal: true

class Transfer < ApplicationRecord
  enum status: %i[paid rejected]
  belongs_to :booking
  belongs_to :payment
end
