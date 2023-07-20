# frozen_string_literal: true

class Licence < ApplicationRecord
  has_one_attached :file
  # validations
  validates :file, presence: true

  enum licence_type: %i[regular hospice others]
  validate_enum_attributes :licence_type

  # Association
  belongs_to :care

  # callbacks
  before_create :set_type

  private

  def set_type
    self.licence_type = 'others' if care.category == 'home_share'
  end
end
