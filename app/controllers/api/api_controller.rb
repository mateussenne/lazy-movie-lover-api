# frozen_string_literal: true

module Api
  class ApiController < ::ApplicationController
    SECRET = 'my$ecretK3y'
    before_action :authorized?

    def current_user
      User.find(decoded_token)
    end

    private

    def authorized?
      return head :unauthorized if decoded_token.blank?
    end

    def decoded_token
      encoded_token = request.headers['Authorization']
      return if encoded_token.blank? || encoded_token == 'Bearer'

      token = encoded_token.split.last
      JWT.decode(token, SECRET, true, algorithm: 'HS256')[0]
    rescue
      nil
    end
  end
end
