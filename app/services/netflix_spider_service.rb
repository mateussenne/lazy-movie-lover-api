# frozen_string_literal: true

require 'kimurai'

class NetflixSpiderService < Kimurai::Base
  @name = 'neflix_spider_service'
  @start_urls = 'https://www.netflix.com/br/browse/genre/5343'
  @engine = :selenium_chrome

  def parse(response, url:, data: {})
    # Scrape start point
    scrape_page
    puts 'scraping'
    # call next page
  end

  private

  def scrape_page
    scrape_response = browser.current_response
    scrape_response.css('ul.nm-content-horizontal-row-item-container').each do |movies_row|
      movies_row.css('li.nm-content-horizontal-row-item').each do |movie|
        url =   movie.css('a.nm-collections-title nm-collections-link')
        image = movie.css('img.nm-collections-title-img')
        name =  movie.css('span.nm-collections-title-name')

        save_movie(name, image, url)
      end
    end
  end

  def save_movie(name, image, url)
    Movie.find_or_create_by!(
      name:  name,
      image: image,
      url:   url
    )
  end
end
