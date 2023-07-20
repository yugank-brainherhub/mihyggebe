class StaffDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :staff_role_id, :care_id
end
