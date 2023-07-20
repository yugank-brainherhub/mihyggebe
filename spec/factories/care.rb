FactoryBot.define do
  factory :care do
    name { "carename" }
    sequence(:address1) { |i| "address#{i}" }
    sequence(:address2) { |i| "address#{i}" }
    sequence(:address3) { |i| "address#{i}" }
    state { "state" }
    county { "countrystate" }
    sequence(:fax_number)  { |i| 000001 + i }
    sequence(:zipcode) { |i| 10000 + i }
    country { "county" }
    status { 'pending' }
    board_members { 'xyz, pqr, rty'}
    category { "senior_living" }
    trait :as_sl do
      category { "senior_living" }
      name { "seniorliving name" }
      after(:create) do |care, _evaluator|
        FactoryBot.create(:licence, care: care)
        FactoryBot.create(:licence, care: care)
        FactoryBot.create(:care_detail, care: care)
      end
    end  
    trait :as_homeshare do
      category { "home_share" }
      name { "homeshare name" }
    end
    association :user
  end
end