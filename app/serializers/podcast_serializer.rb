class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :artwork_image, :publish
end
