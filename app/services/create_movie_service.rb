# frozen_string_literal: true

class CreateMovieService
  attr_reader :movies, :stream_service_code

  def initialize(movies, stream_service_code)
    @movies              = movies
    @stream_service_code = stream_service_code
  end

  def perform
    Movie.upsert_all(movies_with_services, unique_by: :slug)
  end

  private

  def movies_with_services
    stream_service_id = stream_service(stream_service_code)

    movies.map do |movie|
      movie.merge(
        stream_service_id: stream_service_id,
        created_at:        DateTime.current,
        updated_at:        DateTime.current
      )
    end
  end

  def stream_service(code)
    StreamService.find_by(code: code).id
  end
end
