# frozen_string_literal: true

module API
  module V1
    class UserSerializer < BaseSerializer
      set_type :users
      attributes :first_name,
                 :last_name,
                 :email,
                 :mobile,
                 :messenger,
                 :google_meet_url,
                 :above18,
                 :organization,
                 :profession,
                 :address,
                 :accountId,
                 :docusign_status
      attribute :role do |object, _params|
        ::API::V1::RoleSerializer.new(object&.role).serializable_hash
      end
    end
  end
end
