FactoryBot.define do
  factory :wishlist do
    association :user
    association :care
  end
end
