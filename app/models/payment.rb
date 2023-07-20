# frozen_string_literal: true

class Payment < ApplicationRecord
  enum status: %i[paid rejected]
  belongs_to :booking
  
  has_one :refund
end
