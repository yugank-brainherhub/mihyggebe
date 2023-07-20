FactoryBot.define do
  factory :bed_booking do
    association :bed
    association :booking
  end
end
