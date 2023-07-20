# frozen_string_literal: true

class Newsletter < ApplicationRecord
  validates :email, presence: true, uniqueness: { message: I18n.t('newsletter.error') },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
