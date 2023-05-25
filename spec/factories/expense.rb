FactoryBot.define do
  factory :expense do
    name { Faker::Name }
    amount { 100 }
    association :user, factory: :user
  end
end
