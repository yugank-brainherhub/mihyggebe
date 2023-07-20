FactoryBot.define do
  factory :testimonial do
    name { "MyString" }
    description { "MyText" }
    publish { false }
    testimonial_type { "MyString" }
    location { "MyString" }
    gender { "MyString" }
  end
end
