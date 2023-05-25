require 'rails_helper'

RSpec.describe Expense, type: :model do
  subject do
    Expense.new(
      name: 'Expense title',
      amount: 12
    )
  end
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'amount should be present' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it 'amount should be numeric' do
    subject.amount = 'not valid'
    expect(subject).to_not be_valid
  end

  it 'amount should be greater than zero' do
    subject.amount = -10
    expect(subject).to_not be_valid
  end
end
