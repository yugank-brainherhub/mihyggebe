class ProviderSupportSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact_type, :active, :user_id, :phone_number, :email
end
