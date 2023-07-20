FactoryBot.define do
  factory :asset do
    sequence(:sort) { |i| i }
    association :assetable
    file { Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg')}
  end
end
