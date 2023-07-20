# frozen_string_literal: true

class Package < ApplicationRecord
  belongs_to :subscription
  belongs_to :plan
end
