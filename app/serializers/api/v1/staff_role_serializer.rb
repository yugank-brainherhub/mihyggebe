# frozen_string_literal: true

module API
  module V1
    class StaffRoleSerializer < BaseSerializer
      set_type :staff_roles

      attributes :id, :name
    end
  end
end
