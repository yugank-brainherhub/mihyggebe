class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :service_type_id, :desc
end
