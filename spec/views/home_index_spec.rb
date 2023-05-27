require 'rails_helper'

RSpec.describe 'home/index', type: :feature do
  include Warden::Test::Helpers

  before do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
    login_as(@user, scope: :user)
    @group = Group.create(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.create(user: @user, name: 'Electricity', amount: 350)
    visit root_path
  end
end
