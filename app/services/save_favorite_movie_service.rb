# frozen_string_literal: true

class SaveFavoriteMovieService
  attr_reader :user_id, :movie_id

  def initialize(user_id:, movie_id:)
    @movie_id = movie_id
    @user_id = user_id
  end

  def favorite_movie_params
    {
      user_id:  user_id,
      movie_id: movie_id
    }
  end

  def call
    movie = Movie.find(movie_id)

    return if movie.blank?

    FavoriteMovie.create!(favorite_movie_params)
  end
end
