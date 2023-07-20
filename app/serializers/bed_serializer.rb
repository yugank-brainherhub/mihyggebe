class BedSerializer < ActiveModel::Serializer
  attributes :id, :bed_number, :bed_type, :room_id, :service_id
end
