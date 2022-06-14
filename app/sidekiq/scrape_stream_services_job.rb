# frozen_string_literal:true

class ScrapeStreamServicesJob
  include Sidekiq::Job

  def perform
    NetflixSpiderService.crawl!
  rescue => e
    log_errors(e)
  end

  private

  def log_errors(error)
    ScrapeError.create(
      error:             error,
      stream_service_id: 1
    )
  end
end
