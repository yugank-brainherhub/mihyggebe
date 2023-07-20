FactoryBot.define do
  factory :booking do
  	sequence(:bookingID) { |i| "booking#{i+1000}" }
    sequence(:first_name) { |i| "user#{i+1000}" }
    sequence(:last_name) { |i| "user#{i+1000}" }
    sequence(:email) { |i| "useremail#{i+1000}@gmail.com" }
    sequence(:mobile) { |i| "#{i+9190000000}" }
    association :user
    association :care
    association :relationship
    checkin Date.today
    checkout Date.tomorrow
    price_includes 'laundry, WIFI, TV'
    after(:create) do |booking, _evaluator|
      FactoryBot.create(:bed_booking, booking: booking, bed: Bed.first)
    end
  end
end
