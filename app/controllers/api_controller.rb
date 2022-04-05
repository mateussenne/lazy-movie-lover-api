# frozen_string_literal: true

class ApiController < ApplicationController
  def index
    movies = Movie.all
    render json: movies
  end

  def scrape
    NetflixSpiderService.crawl!
  end
end
