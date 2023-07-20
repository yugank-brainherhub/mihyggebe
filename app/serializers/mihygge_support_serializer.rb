class MihyggeSupportSerializer < ActiveModel::Serializer
  attributes :id, :support_type, :description, :file_1, :user_id, :email, :phone_number, :first_name, :last_name, :support_number, :is_provider, :provider_id
end
