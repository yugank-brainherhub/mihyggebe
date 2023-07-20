# frozen_string_literal: true

class Subscription < ApplicationRecord
  enum status: %i[active inactive]
  belongs_to :user
  belongs_to :care
  has_one :subscription_refunds
  has_many :packages, dependent: :destroy
  has_many :plans, through: :packages
  validates :subscriptionId, :planId, presence: true
end
