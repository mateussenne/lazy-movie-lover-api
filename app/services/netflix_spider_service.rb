# frozen_string_literal: true

require 'kimurai'

class NetflixSpiderService < Kimurai::Base
  STREAM_SERVICE_CODE = :netflix

  # Variables utilized in Kimurai's parse method
  @name       = 'neflix_spider'
  @start_urls = ['https://www.netflix.com/br/browse/genre/5343']
  @engine     = :selenium_chrome

  def parse(response, url:, data: {})
    # Scrape start point
    scrape_page

    # call next page
  end

  private

  def scrape_page
    scrape_response = browser.current_response
    scrape_response.css("//ul[@class='nm-content-horizontal-row-item-container']").each do |movies_row|
      movies = mount_movies(movies_row.css('li.nm-content-horizontal-row-item'))
      save_movies(movies)
    end
  end

  def mount_movies(movies)
    movies.map do |movie|
      {
        url:          movie.css('a')[0]['href'],
        name:         movie.css('span.nm-collections-title-name')&.text&.squish,
        slug:         movie.css('span.nm-collections-title-name')&.text&.squish&.parameterize,
        poster_image: movie.css('img.nm-collections-title-img')[0]['src'],
        synopsis:     'bla bla bla'
      }
    end
  end

  def save_movies(movies)
    SaveMovieService.new(movies, STREAM_SERVICE_CODE).perform
  end
end
