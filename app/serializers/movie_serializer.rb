# frozen_string_literal: true

class MovieSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :synopsis,
    :url,
    :poster_image

  has_one :stream_service
end
