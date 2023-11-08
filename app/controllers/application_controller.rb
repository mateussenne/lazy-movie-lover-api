# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized?

  def current_user
    return if decoded_token.blank?

    User.find(decoded_token)
  end

  def encode_token(payload)
    JWT.encode(payload.to_s, ENV.fetch('authorization_secret'), 'HS256')
  end

  private

  def authorized?
    return head :unauthorized if decoded_token.blank?
  end

  def decoded_token
    return if encoded_token.blank? || encoded_token == 'Bearer'

    token = encoded_token.split.last
    JWT.decode(token, ENV.fetch('authorization_secret'), true, algorithm: 'HS256')[0]
  rescue
    nil
  end

  def encoded_token
    request.headers['Authorization']
  end
end
