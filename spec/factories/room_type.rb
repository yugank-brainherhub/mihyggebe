FactoryBot.define do
  factory :room_type do
    trait :dining do
      name { 'Dining room' }
    end

    trait :living do
      name { 'Living room' }
    end

    trait :kitchen do
      name { "Kitchen" }
    end
    
    trait :parking do
      name { "Parking Lot" }
    end
  end
end
