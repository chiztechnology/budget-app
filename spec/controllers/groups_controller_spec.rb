require 'rails_helper'
require_relative '../support/devise'

RSpec.describe GroupsController, type: :controller do
  let!(:user) { User.create(name: 'Prangon Ghose', email: 'test@example.com', password: '12345678') }
  before(:each) do
    # user.confirm
    sign_in user
    @group = Group.create(name: 'new', icon: 'www.test.com', user:)
    @group2 = Group.create(name: 'new2', icon: 'www.test2.com', user:)
  end

  describe 'Get id' do
    it 'returns a successful response' do
      get :show, params: { id: @group.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'renders template index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new group' do
        expect do
          post :create, params: { group: { name: 'new', icon: 'www.test.com' } }
        end.to change(Group, :count).by(1)
      end

      it 'redirects to the groups index page' do
        post :create, params: { group: { name: 'new', icon: 'www.test.com' } }
        expect(response).to redirect_to(groups_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new group' do
        expect do
          post :create, params: { group: { name: '' } }
        end.not_to change(Group, :count)
      end

      it 'renders the new template' do
        post :create, params: { group: { name: '' } }
        expect(response).to render_template(:new)
      end
    end
  end
end
