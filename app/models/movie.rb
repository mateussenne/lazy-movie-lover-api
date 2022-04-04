# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :stream_service, optional: false
  validates :name, :url, :image, presence: true
end
