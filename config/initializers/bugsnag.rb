if false
unless Rails.env.development? || Rails.env.test?
  Bugsnag.configure do |config|
    config.api_key = SECRETS[:bugsnag_key]
  end
end
end