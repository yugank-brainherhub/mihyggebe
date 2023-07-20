class WishlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :care_id
end
