# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'

  # Configure Sidekiq-specific session middleware
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'movies#index'

  namespace :api do
    scope :movies do
      get '/', to: 'movies#index'
      post 'favorite/:movie_id', to: 'movies#save_favorite'
    end

    resources :users
    post 'login', to: 'users#login'
  end
end
