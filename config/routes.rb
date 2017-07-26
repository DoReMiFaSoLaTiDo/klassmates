Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  namespace :api, defaults: { format: :json }, path: '/api' do
    # resources :transactions, only: [:show]
    resources :users, only: [:show, :index, :create, :update, :destroy] do
      resources :transactions, only: [:show, :index, :create, :update, :destroy]
      resources :profiles, only: [:edit, :show, :update]
    end
    resources :profiles, only: [:show, :index]
    resources :sessions, only: [:create, :destroy]
    # resources :contributions, only: [:show, :index, :create, :update, :destroy]
  end

  namespace :admin, defaults: { format: :json }, path: '/admin' do
    resources :roles, only: [:show, :index, :create, :update, :destroy]
    resources :transactions, except: [:create]
    resources :users, except: [:show]
  end


  # You can have the root of your site routed with "root"
  root 'home#index'


end
