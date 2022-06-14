# frozen_string_literal:true

class ScrapeStreamServicesJob
  include Sidekiq::Job

  def perform
    NetflixSpiderService.crawl!
  end
end
