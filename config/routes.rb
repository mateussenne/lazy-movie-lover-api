# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'

  # Configure Sidekiq-specific session middleware
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'
  mount Sidekiq::Web => '/sidekiq'

  scope :api do
    root to: 'api#index'
  end
end
