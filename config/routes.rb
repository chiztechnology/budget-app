Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :home, only: %i[index]
  resources :groups, only: %i[index show new create] do |r|
    resources :expenses, only: %i[index new create]
  end
end
