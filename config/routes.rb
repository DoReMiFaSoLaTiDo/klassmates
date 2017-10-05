Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  devise_for :users, :controllers => { registrations: 'registrations' }

  # devise_scope :user do
  #   get '/users/sign_in' => "devise/sessions#new", :as => :login
  # end

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

  namespace :admin, path: '/admin' do
    resources :roles, only: [:show, :index, :create, :update, :destroy]
    resources :transactions, except: [:create]
    resources :users, except: [:new]
  end

  namespace :strategist, path: '/strategist' do
    resources :transactions, except: [:create]
  end

  namespace :advocate, path: '/advocate' do
    root to: "dashboard#show"
    resources :users, except: [:create, :delete]
  end

  resources :users, only: [:show, :index, :create, :update, :destroy] do
    resources :transactions, only: [:new, :show, :index, :create, :update, :destroy], controller: 'users/transactions'
    resources :profiles, only: [:edit, :show, :update], controller: 'users/profiles'
    # resources :dashboard, only: [:show]
  end
  resources :profiles, only: [:show, :index, :update]
  get '/dashboard', to: 'dashboard#show', as: 'dashboard'
  # resources :dashboard, only: [:show]
  resources :transactions, only: [:new, :show, :index, :create, :update, :destroy]
  # You can have the root of your site routed with "root"
  root 'home#index'

  # match "/:path_name", to: "home##{:path_name}", via: :all

end
