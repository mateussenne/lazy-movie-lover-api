# frozen_string_literal: true

require 'kimurai'

class NetflixSpiderService < Kimurai::Base
  STREAM_SERVICE_CODE = :netflix

  # Variables utilized in Kimurai's parse method
  @name       = 'neflix_spider'
  @start_urls = [ENV.fetch('netflix_url')]
  @engine     = :mechanize

  def parse(_response, url:, data: {})
    # Scrape start point
    scrape_page
  end

  private

  def scrape_page
    scrape_response = browser.current_response
    scrape_response.css("//ul[@class='nm-content-horizontal-row-item-container']").each do |movies_row|
      movies = mount_movies(movies_row.css('li.nm-content-horizontal-row-item'))
      create_movies(movies)
    end
  end

  def mount_movies(movies)
    movies.map do |movie|
      {
        url:          movie_url(movie),
        name:         movie.css('span.nm-collections-title-name')&.text&.squish,
        slug:         movie.css('span.nm-collections-title-name')&.text&.squish&.parameterize,
        poster_image: movie.css('img.nm-collections-title-img')[0]['src']
      }
    end
  end

  def movie_url(movie)
    movie.css('a')[0].nil? ? 'http://netflix.com' : movie.css('a')[0]['href']
  end

  def create_movies(movies)
    CreateMovieService.new(movies, STREAM_SERVICE_CODE).call
  end
end
