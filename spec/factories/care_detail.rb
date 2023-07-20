FactoryBot.define do
  factory :care_detail do
    association :care
    description 'attached'
    area_description 'attached'
    no_of_restrooms 6
    no_of_beds 3
    no_of_rooms 2
  end
end
