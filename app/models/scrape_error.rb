# frozen_string_literal: true

class ScrapeError < ApplicationRecord
  belongs_to :stream_service
  validates  :error, presence: true
end
