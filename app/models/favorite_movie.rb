# frozen_string_literal: true

class FavoriteMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validate :favorite?

  def favorite?
    return unless FavoriteMovie.where(user_id: user_id, movie_id: movie_id).length.positive?

    errors.add(:movie, 'This movie is already a favorite')
  end
end

