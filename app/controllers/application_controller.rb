# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized?

  def authorization?
    params[:access_key] == Rails.application.credentials.dig(:navigation, :access_key)
  end

  def authorized?
    render json: { message: 'please contact the administrator' }, status: :unauthorized unless authorization?
  end
end
