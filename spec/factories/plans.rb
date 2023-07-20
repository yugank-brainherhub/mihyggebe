FactoryBot.define do
  factory :plan do
    min { 1 }
    max { 1 }
    planId { "MyString" }
    price { 1.5 }
    status { 1 }
  end
end
