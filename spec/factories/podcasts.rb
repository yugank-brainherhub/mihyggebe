FactoryBot.define do
  factory :podcast do
    title { "MyString" }
    description { "MyText" }
    artwork_image { "MyString" }
    publish { false }
  end
end
