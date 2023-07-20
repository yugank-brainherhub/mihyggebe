require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [SECRETS[:sidekiq_username], SECRETS[:sidekiq_password]]
end

sidekiq_config = if Rails.env.development? || Rails.env.test?
		   { url: 'redis://localhost:6379/0' }
		 else
		   { url: SECRETS[:redis_url] }
		 end

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
  end
end
