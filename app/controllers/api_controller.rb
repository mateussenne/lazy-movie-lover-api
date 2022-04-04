# frozen_string_literal: true

class ApiController < ApplicationController
  def index
    movies = Movie.all
    render json: movies
  end
end
