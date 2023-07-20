FactoryBot.define do
  factory :mihygge_support do
    support_type { "MyString" }
    description { "MyText" }
    file_1 { "MyString" }
    user_id { 1 }
    email { "MyString" }
    phone_number { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    support_number { "MyString" }
    is_provider { false }
    provider_id { 1 }
  end
end
