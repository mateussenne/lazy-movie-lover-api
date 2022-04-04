# frozen_string_literal: true

class StreamService < ApplicationRecord
  has_many :movies, dependent: :destroy
  validates :name, :base_url, presence: true
end
