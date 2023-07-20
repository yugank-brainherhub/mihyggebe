# frozen_string_literal: true

class StaffDetail < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :name, format: { with: /^[a-zA-Z.\s]*$/, multiline: true, message: I18n.t('user.name_error') }
  validates_uniqueness_of :name, scope: %i[staff_role_id care_id]
  validates_uniqueness_of :staff_role_id, scope: %i[care_id]
  # Association
  belongs_to :care
  belongs_to :staff_role
end
