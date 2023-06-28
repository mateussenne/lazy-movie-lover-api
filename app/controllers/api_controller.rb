# frozen_string_literal: true

class ApiController < ApplicationController
  before_action :authorized?

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

  private

  def filter(params)
    params.slice(:stream_service)
  end

  def search_params
    params[:search]
  end
end
