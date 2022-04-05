# frozen_string_literal: true

require 'kimurai'

class NetflixSpiderService < Kimurai::Base
  @name = 'neflix_spider_service'
  @start_urls = 'https://www.netflix.com/br/browse/genre/5343'
  @engine = :selenium_chrome

  def parse(response, url:, data: {})
    # Scrape start point
    scrape_page

    # call next page
  end

  private

  def scrape_page
    scrape_response = browser.current_response
    scrape_response.css('ul.nm-content-horizontal-row-item-container').each do |movies_row|
      movies_row.css('li.nm-content-horizontal-row-item').each do |movie_item|
        movie = {}

        movie[:url] =   movie_item.css('a.nm-collections-title nm-collections-link')
        movie[:name] =  movie_item.css('span.nm-collections-title-name')
        movie[:image] = movie_item.css('img.nm-collections-title-img')

        save_movie(movie)
      end
    end
  end

  def save_movie(movie)
    Movie.find_or_create_by!(movie)
  end

  def generate_movie_slug(name)
    name.parameterize
  end
end
