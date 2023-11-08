# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, :username, presence: true
  validates :email, uniqueness: true, presence: true
  has_many :favorite_movies, dependent: :destroy
end
