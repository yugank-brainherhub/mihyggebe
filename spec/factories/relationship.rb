FactoryBot.define do
  factory :relationship do
    trait :as_brother do
      name { "Brother" }
    end

    trait :as_mother do
      name { "mother" }
    end

    trait :as_father do
      name { "Father" }
    end
    
    trait :as_grandmother do
      name { "Grand mother" }
    end
  end
end
