# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :stream_service, optional: false
  validates :name, :url, :poster_image, presence: true
  validates :slug, presence: true, uniqueness: true
  self.per_page = 30

  scope :search_by_name, ->(params) { where('movies.name LIKE ?', "%#{params}%") }
  scope :filter_by_stream_service, lambda { |stream_service|
                                     joins(:stream_service).where(stream_service: { code: stream_service })
                                   }
end
