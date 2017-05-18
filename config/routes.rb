Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json }, path: '/api' do
    resources :roles, only: [:show, :index, :create, :update, :destroy]
    resources :transactions, only: [:show]
    resources :users, only: [:show, :index, :create, :update, :destroy] do
      resources :transactions, only: [:show, :index, :create, :update, :destroy]
    end

    resources :sessions, only: [:create, :destroy]
    # resources :contributions, only: [:show, :index, :create, :update, :destroy]
  end

  # You can have the root of your site routed with "root"
  root 'home#index'


end
