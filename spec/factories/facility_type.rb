FactoryBot.define do
  factory :facility_type do
    trait :general_wellness do
      name { 'General & Wellness' }
      after(:create) do |ft, _evaluator|
        create(:facility, facility_type: ft, name: 'Wheel Chair Access' )
        create(:facility, facility_type: ft, name: 'Ramp' )
      end
    end

    trait :parking do
      name { 'Parking' }
      after(:create) do |ft, _evaluator|
        create(:facility, facility_type: ft, name: 'Private' )
        create(:facility, facility_type: ft, name: 'Valet' )
      end
    end

    trait :pets do
      name { "Pets" }
      after(:create) do |ft, _evaluator|
        create(:facility, facility_type: ft, name: 'Pets in residence' )
        create(:facility, facility_type: ft, name: 'Personal pets allowed' )
      end
    end
    
    trait :meals do
      name { "Meals" }
    end
  end
end