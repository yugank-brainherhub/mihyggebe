# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  rescue_from Net::SMTPAuthenticationError do |exception|
    Bugsnag.notify(exception)
  end
  layout 'mailer'
end
