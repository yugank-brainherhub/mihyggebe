class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :room_type, :bathroom_type, :price, :available_from, :available_to, :price_desc, :care_id, :beds_count
end
