# frozen_string_literal: true

require 'kimurai'

class NetflixSpiderService < Kimurai::Base
  STREAM_SERVICE_CODE = :netflix

  # Variables utilized in Kimurai's parse method
  @name       = 'neflix_spider_service'
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
        movie = {}

        movie[:url]            = movie_item.css('a')[0]['href']
        movie[:name]           = movie_item.css('span.nm-collections-title-name')&.text&.squish
        movie[:image]          = movie_item.css('img.nm-collections-title-img')[0]['src']
        movie[:synopsis]       = 'bla bla bla'
        movie[:stream_service] = STREAM_SERVICE_CODE

        save_movie(movie)
      end
    end
  end

  def save_movie(movie)
    SaveMovieService.new(movie).perform
  end
end
