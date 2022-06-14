# frozen_string_literal:true

class ScrapeStreamServicesJob
  include Sidekiq::Job

  def perform
    NetflixSpiderService.crawl!
    run_again
  end

  private

  def run_again
    self.class.perform_at(24.hours.from_now)
  end
end
