# frozen_string_literal:true

class ScrapeStreamServicesJob
  include Sidekiq::Job

  def perform
    NetflixSpiderService.crawl!
    perform_in(30.seconds.from_now)
  end
end
