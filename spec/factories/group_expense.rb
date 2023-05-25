FactoryBot.define do
  factory :group_expense do
    association :expense, factory: :expense
    association :group, factory: :group
  end
end
