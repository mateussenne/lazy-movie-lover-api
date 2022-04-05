# frozen_string_literal: true

class ApiController < ApplicationController
  def index
    movies = Movie.all
    render json: movies
  end

  def scrape
    render json: { hey: 'hi' }
  end
end
