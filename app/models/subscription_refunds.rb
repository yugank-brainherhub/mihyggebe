# frozen_string_literal: true

class SubscriptionRefunds < ApplicationRecord
  belongs_to :subscription
  validates :refundId, presence: true
end
