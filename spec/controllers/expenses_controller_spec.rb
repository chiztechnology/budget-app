require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ExpensesController, type: :controller do
  let!(:user) { User.create(name: 'Prangon Ghose', email: 'test@example.com', password: '12345678') }
  let!(:group) { Group.create(name: 'Group 1', icon: 'www.test.com', user:) }
  let!(:group2) { Group.create(name: 'Group 2', icon: 'www.test2.com', user:) }
  before(:each) do
    # user.confirm
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new expense and redirects to group page' do
        expect do
          post :create,
               params: { group_id: group.id, expense: { name: 'New Expense', amount: 100, group_ids: [group2.id] } }
        end.to change(Expense, :count).by(1)
        expect(response).to redirect_to(group_path(group))
      end
    end

    context 'with invalid params' do
      it 'does not create a new expense and renders new template' do
        expect do
          post :create, params: { group_id: group.id, expense: { name: '', amount: '', group_ids: [] } }
        end.to_not change(Expense, :count)
        expect(response).to redirect_to("/groups/#{group.id}/expenses/new")
      end
    end
  end
end
