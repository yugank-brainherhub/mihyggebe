FactoryBot.define do
  factory :bed do
    sequence(:bed_number) { |i| "#{i}" }
    bed_type 'king'
    association :room
  end
end
