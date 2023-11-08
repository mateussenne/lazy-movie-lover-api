# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    skip_before_action :authorized?, only: [:login]

    def index
      users = User.all
      render json: users
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: { user: user }
      else
        render json: user.errors
      end
    end

    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        render json: { token: encode_token(user.id) }
      else
        render json: 'Incorrect email or password', status: :unauthorized
      end
    end

    def profile
      profile_with_movies = User.includes(favorite_movies: :movie).find(current_user.id)
      render json: { user: profile_with_movies, favorite_movies: profile_with_movies.favorite_movies.map(&:movie) }
    end

    private

    def user_params
      params.require(:user).permit(%i[name username email age password])
    end
  end
end
