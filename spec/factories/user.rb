FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "email#{i}test@gmail.com" }
    first_name { "testuser" }
    last_name { "testlastname" }
    sequence(:messenger)  { |i| Faker::Name.name + i.to_s }
    sequence(:mobile) { |i| '100-000-000' + i.to_s }
    above18 true
    association :role
    password { 'Test@1234' }
    password_confirmation { 'Test@1234' }
    email_confirmed true
  end
end