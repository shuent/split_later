Rails.application.routes.draw do

  devise_for :users

  authenticate :user do
    root to: 'home#index'
    resources :home
  end

  namespace :api, { format: :json } do
    authenticate :user do
      resources :home
    end
    resource :login, only: [:create], controller: :sessions
    resource :users, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
