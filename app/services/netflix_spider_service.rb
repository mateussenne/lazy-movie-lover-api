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
      movies_row.css('li.nm-content-horizontal-row-item').each do |movie_item|
        movie = mount_movie(movie_item)
        save_movie(movie)
      end
    end
  end

  def mount_movie(movie_item)
    {
      url:            movie_item.css('a')[0]['href'],
      name:           movie_item.css('span.nm-collections-title-name')&.text&.squish,
      poster_image:   movie_item.css('img.nm-collections-title-img')[0]['src'],
      synopsis:       'bla bla bla',
      stream_service: STREAM_SERVICE_CODE
    }
  end

  def save_movie(movie)
    SaveMovieService.new(movie).perform
  end
end
