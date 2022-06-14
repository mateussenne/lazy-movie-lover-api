# frozen_string_literal: true

class ApiController < ApplicationController
  def index
    if authorized?
      movies = Movie.paginate(page: params[:page], per_page: 30)
      render json: movies
    else
      render json: { message: 'please contact the administrator' }, status: :unauthorized
    end
  end

  private

  def authorized?
    params[:authorization] == Rails.application.credentials.dig(:navigation, :access_key)
  end
end
