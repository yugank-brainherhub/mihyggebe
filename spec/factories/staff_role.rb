FactoryBot.define do
  factory :staff_role do
    trait :as_owner do
      name { "Owner" }
    end

    trait :as_administrator do
      name { "Administrator" }
    end

    trait :as_ed do
      name { "Executive_director" }
    end
    
    trait :as_ad do
      name { "Admissions Director" }
    end
  end
end