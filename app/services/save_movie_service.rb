# frozen_string_literal: true

class SaveMovieService
  attr_reader :movie

  def initialize(movie)
    @movie = movie
  end

  def perform
    Movie.find_or_initialize_by(slug: generate_movie_slug(movie[:name])).update!(
      name:           movie[:name],
      poster_image:   movie[:poster_image],
      synopsis:       movie[:synopsis],
      url:            movie[:url],
      stream_service: load_stream_service(movie[:stream_service])
    )
  end

  private

  def generate_movie_slug(name)
    name.parameterize
  end

  def load_stream_service(code)
    StreamService.find_by(code: code)
  end
end
