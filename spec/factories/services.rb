FactoryBot.define do
  factory :service do
    name { 'Self' }
    association :service_type
  end
end
