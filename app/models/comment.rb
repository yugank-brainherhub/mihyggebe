# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :resource, polymorphic: true
  validates :description, presence: true
end
