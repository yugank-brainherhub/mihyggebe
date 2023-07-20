FactoryBot.define do
  factory :provider_support do
    name { "MyString" }
    contact_type { "MyString" }
    active { false }
    user_id { 1 }
    phone_number { "MyString" }
    email { "MyString" }
  end
end
