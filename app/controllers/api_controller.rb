# frozen_string_literal: true

class ApiController < ApplicationController
  def index

    movies = Movie.paginate(page: params[:page], per_page: 30)
    render json: movies
  end

  private

  def authorized?
    pa
  end
end
