# frozen_string_literal: true

require 'kimurai'

class PrimeVideoSpiderService < Kimurai::Base
  STREAM_SERVICE_CODE = :prime_video

  # Variables utilized in Kimurai's parse method
  @name       = 'prime_video_spider'
  @start_urls = ['https://www.amazon.com/Prime-Movies/b?ie=UTF8&node=7613704011']
  @engine     = :selenium_chrome

  def parse(_response, url:, data: {})
    # Scrape start point
    scrape_page

  end

  private

  def scrape_page
    scrape_response = browser.current_response
    scrape_response.css("//li[@class='-e5Lt1 tst-card-wrapper tst-hoverable-card']").each do |movie_item|
      movie = mount_movie(movie_item)
      save_movie(movie)
    end
  end

  def mount_movie(movie_item)
    {
      name:           movie_item.css('a')[0]['aria-label'],
      url:            movie_item.css('a')[0]['href'],
      poster_image:   movie_item.css('img')[0]['src'],
      stream_service: STREAM_SERVICE_CODE
    }
  end

  def save_movie(movie)
    SaveMovieService.new(movie).perform
  end
end
