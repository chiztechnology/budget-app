FactoryBot.define do
  factory :group do
    name { Faker::Name }
    icon { Faker::Internet.url }
    association :user, factory: :user
  end
end
