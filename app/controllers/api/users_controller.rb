# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
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

    private

    def user_params
      params.require(:user).permit(%i[name username email age password])
    end
  end
end
