FactoryBot.define do
  factory :room do
  	sequence(:name) { |i| "room#{i}" }
  	room_type 'for-three'
    association :care
    bathroom_type 'attached'
    price 60
    available_from Date.today
    available_to Date.tomorrow
    price_desc 'laundry, WIFI, TV'
  end
end
