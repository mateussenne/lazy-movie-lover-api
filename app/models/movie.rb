# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :stream_service, optional: false
  validates :name, :url, :poster_image, presence: true
end
