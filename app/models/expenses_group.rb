class ExpensesGroup < ApplicationRecord
  belongs_to :group
  belongs_to :expense

  validates :expense_id, uniqueness: { scope: :group_id }
end
