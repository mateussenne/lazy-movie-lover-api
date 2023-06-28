# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authorization?
    params[:authorization] == Rails.application.credentials.dig(:navigation, :access_key)
  end

  def authorized?
    render json: { message: 'please contact the administrator' }, status: :unauthorized unless authorization?
  end
end
