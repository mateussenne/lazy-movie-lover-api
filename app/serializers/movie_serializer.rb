# frozen_string_literal: true

class MovieSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :synopsis,
    :url,
    :poster_image,
    :stream_service

  def stream_service
    object.stream_service.name
  end
end
