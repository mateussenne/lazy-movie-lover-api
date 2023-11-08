# frozen_string_literal: true

module Api
  class MoviesController < ApplicationController
    def index
      movies = if search_params.present?
                 Movie.search_by_name(search_params).paginate(page: params[:page])
               else
                 Movie.paginate(page: params[:page])
               end
      filter(params).each do |key, value|
        movies = movies.public_send("filter_by_#{key}", value) if value.present?
      end
      render json: movies
    end

    def save_favorite
      favorite = SaveFavoriteMovieService.new(user_id: current_user.id, movie_id: params[:movie_id])
      if favorite.call
        render json: favorite, status: :ok
      else
        render json: favorite.errors
      end
    end

    private

    def filter(params)
      params.slice(:stream_service)
    end

    def search_params
      params[:search]
    end
  end
end
