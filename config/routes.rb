require "sidekiq/web"

Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  mount Sidekiq::Web => 'sidekiq'

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :institutions do
    resources :permissions, except: [:show]
    resources :jobs
  end
  
  resources :jobs do
    resources :subscriptions, only: [:index, :new, :create]
  end
  resources :subscriptions, only: [:show, :edit, :update]

end
