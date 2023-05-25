require 'rails_helper'

RSpec.describe 'groups/index.html.erb', type: :feature do
  let(:user) { User.create(name: 'Prangon Ghose', email: 'test@example.com', password: '12345678') }
  before(:each) do
    # user.confirm
    sign_in user
    @group = Group.create(name: 'Group1', icon: 'https://picsum.photos/70/70', user:)
    @group2 = Group.create(name: 'Group2', icon: 'https://picsum.photos/70/70', user:)
    @expense1 = Expense.create(name: 'expense1', amount: 20, user:)
    @expense2 = Expense.create(name: 'expense2', amount: 30, user:)
    @expense3 = Expense.create(name: 'expense3', amount: 50, user:)
    @expense4 = Expense.create(name: 'expense4', amount: 60, user:)
    @group2.expenses << @expense1
    @group2.expenses << @expense2
    @group.expenses << @expense3
    @group.expenses << @expense4
  end

  context 'when the user visits show page for category 1' do
    before { visit group_path(@group) }

    it 'Shows the title of the page' do
      expect(page).to have_content('YOUR TRANSACTIONS')
    end

    it 'Shows only the name of the expenses for that group' do
      expect(page).to have_content(@group.name)
      expect(page).not_to have_content(@group2.name)
    end

    it 'Shows the total amount of the group' do
      expect(page).to have_content(110)
    end

    it 'Shows only the name of the expenses for that group' do
      expect(page).to have_content(@expense3.name)
      expect(page).to have_content(@expense4.name)
      expect(page).not_to have_content(@expense1.name)
      expect(page).not_to have_content(@expense2.name)
    end

    it 'Shows the date of creation of the groups' do
      expect(page).to have_content(@expense3.created_at.strftime('%d %b %Y'))
      expect(page).to have_content(@expense4.created_at.strftime('%d %b %Y'))
    end

    it 'Shows the transaction amount' do
      expect(page).to have_content(@expense3.amount)
      expect(page).to have_content(@expense4.amount)
    end

    it 'redirects me to a add another transaction' do
      link = find("a[href='#{new_group_expense_path(@group)}']")
      link.click
      expect(page).to have_current_path(new_group_expense_path(@group))
    end
  end

  context 'when the user visits show page for category 2' do
    before { visit group_path(@group2) }

    it 'Shows the title of the page' do
      expect(page).to have_content('YOUR TRANSACTIONS')
    end

    it 'Shows only the name of the expenses for that group' do
      expect(page).not_to have_content(@group.name)
      expect(page).to have_content(@group2.name)
    end

    it 'Shows the total amount of the group' do
      expect(page).to have_content(50)
    end

    it 'Shows only the name of the expenses for that group' do
      expect(page).not_to have_content(@expense3.name)
      expect(page).not_to have_content(@expense4.name)
      expect(page).to have_content(@expense1.name)
      expect(page).to have_content(@expense2.name)
    end

    it 'Shows the date of creation of the groups' do
      expect(page).to have_content(@expense1.created_at.strftime('%d %b %Y'))
      expect(page).to have_content(@expense2.created_at.strftime('%d %b %Y'))
    end

    it 'Shows the transaction amount' do
      expect(page).to have_content(@expense1.amount)
      expect(page).to have_content(@expense2.amount)
    end

    it 'redirects me to a add another transaction' do
      link = find("a[href='#{new_group_expense_path(@group2)}']")
      link.click
      expect(page).to have_current_path(new_group_expense_path(@group2))
    end
  end
end
