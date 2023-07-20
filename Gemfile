source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use stripe for payment
gem 'stripe', '~> 5.10'
# Use Puma as the app server
gem 'puma', '~> 3.11'

gem 'pg', '~> 1.1', '>= 1.1.4'
gem 'rack-cors'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'geocoder'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'active_model_serializers', '~> 0.10.9'
gem 'bugsnag', '~> 6.12', '>= 6.12.2'
gem 'docusign_esign', '~> 1.0'
gem 'fast_jsonapi', '~> 1.5'
gem 'uncouple', '~> 0.2.2', require: 'uncouple/rails'
gem 'turbolinks'
gem 'jquery-rails'
gem 'bootstrap', '~> 4.3.1'
gem 'pg_search', '~> 2.3', '>= 2.3.2'
gem 'sass-rails', '>= 3.2'
gem 'simple_form', '~> 5.0', '>= 5.0.1'
gem 'haml-rails', '~> 2.0', '>= 2.0.1'
gem 'pundit', '~> 2.1.0'
gem 'versionist', '~> 2.0.1'
gem 'jwt', '~> 2.2.1'
gem 'bcrypt', '~> 3.1.13'
gem 'kaminari', '~> 1.1.1'
gem 'aws-sdk-s3', '~> 1.46.0'
gem 'bootstrap4-kaminari-views', '~> 1.0', '>= 1.0.1'
gem 'enum_attributes_validation'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
gem 'mina'
gem 'mina-multistage', require: false
gem 'sidekiq'
gem 'sidekiq-status'
gem 'jquery-datatables'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'bullet'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'letter_opener'
  gem 'pry-nav'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rspec-rails'
  gem 'rspec_api_documentation'
  gem "apitome"
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'
  #gem 'spring-watcher-listen', '~> 2.0.0'
end

group :staging, :uat, :production do 
  gem 'skylight', '~> 4.2', '>= 4.2.2'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
