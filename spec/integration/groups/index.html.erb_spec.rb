require 'rails_helper'

RSpec.describe 'groups/index.html.erb', type: :feature do
  let(:user) { User.create(name: 'Prangon Ghose', email: 'test@example.com', password: '12345678') }
  before(:each) do
    # user.confirm
    sign_in user
    @group = Group.create(name: 'new', icon: 'https://picsum.photos/70/70', user:)
    @group2 = Group.create(name: 'new2', icon: 'https://picsum.photos/70/70', user:)
    @expense1 = Expense.create(name: 'expense1', amount: 20, user:)
    @expense2 = Expense.create(name: 'expense2', amount: 30, user:)
    @expense3 = Expense.create(name: 'expense2', amount: 50, user:)
    @expense4 = Expense.create(name: 'expense4', amount: 60, user:)
    @group2.expenses << @expense1
    @group2.expenses << @expense2
    @group.expenses << @expense3
    @group.expenses << @expense4
    visit groups_path
  end

  it 'Shows the title of the page' do
    expect(page).to have_content('CATEGORIES')
  end

  it 'Shows the name of the groups' do
    expect(page).to have_content(@group.name)
    expect(page).to have_content(@group2.name)
  end

  it 'Shows the total amount of the groups' do
    expect(page).to have_content(50)
    expect(page).to have_content(110)
  end

  it 'Shows the date of creation of the groups' do
    expect(page).to have_content(@group.created_at.strftime('%d %b %Y'))
    expect(page).to have_content(@group2.created_at.strftime('%d %b %Y'))
  end

  it 'redirects me to a specifc group' do
    link = find("a[href='#{group_path(@group.id)}']")
    link.click
    expect(page).to have_current_path(group_path(@group.id))
  end

  it 'redirects me to a add another group' do
    link = find("a[href='#{new_group_path}']")
    link.click
    expect(page).to have_current_path(new_group_path)
  end
end
