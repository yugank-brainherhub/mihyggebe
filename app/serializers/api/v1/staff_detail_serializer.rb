# frozen_string_literal: true

module API
  module V1
    class StaffDetailSerializer < BaseSerializer
      set_type :staff_details

      attributes :id, :name

      attribute :role do |object, _params|
        object.staff_role.name
      end
    end
  end
end
