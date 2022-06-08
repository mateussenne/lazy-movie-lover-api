# frozen_string_literal: true

class ApiController < ApplicationController
  def index
    movies = Movie.paginate(page: params[:page], per_page: 30)
    render json: movies
  end

  def scrape
    NetflixSpiderService.crawl!
  end
end
