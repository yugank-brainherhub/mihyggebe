FactoryBot.define do
  factory :room_service_type do
    trait :utility do
      name { 'Utility' }
      after(:create) do |ft, _evaluator|
        create(:room_service, room_service_type: ft, name: 'Air-conditioning' )
        create(:room_service, room_service_type: ft, name: 'Fans' )
      end
    end
  end
end
