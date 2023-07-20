# frozen_string_literal: true

class Refund < ApplicationRecord
  enum status: %i[success failed]
  belongs_to :booking
  belongs_to :payment
end
