# frozen_string_literal: true

class StreamService < ApplicationRecord
  has_many :movies, dependent: :destroy
  validates :name, :base_url, presence: true
  before_create :set_service_code

  private

  def set_service_code
    self.code = name.parameterize.gsub('-', '_')
  end
end
