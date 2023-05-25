require 'rails_helper'
require_relative '../support/devise'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Prangon Ghose', email: 'test@example.com', password: '12345678') }
    context 'when user is signed in' do
      before do
        # user.confirm
        sign_in user
        get :index
      end
      it 'redirects to groups_path' do
        expect(response).to redirect_to(groups_path)
      end
    end

    context 'when user is not signed in' do
      before do
        get :index
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
