FactoryBot.define do
  factory :user do
    name { Faker::Name }
    sequence(:email) { |n| "user_#{n}@factory.com" }
    password { Faker::Alphanumeric }
  end
end
