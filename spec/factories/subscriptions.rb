FactoryBot.define do
  factory :subscription do
    user_id { 1 }
    subscriptionId { "MyString" }
    planId { "MyString" }
    care_id { 1 }
    payment_intent { "MyString" }
    subscribed_at { "2021-11-02 22:20:56" }
    status { 1 }
  end
end
