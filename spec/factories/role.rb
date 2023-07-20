FactoryBot.define do
  factory :role do
    trait :as_customer do
      name { "customer" }
    end

    trait :as_admin do
      name { "admin" }
    end

    trait :as_provider do
      name { "provider" }
    end
    
    trait :as_social_worker do
      name { "social_worker" }
    end
  end
end
