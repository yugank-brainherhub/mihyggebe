# frozen_string_literal: true

module API
  module V1
    class RoleSerializer < BaseSerializer
      set_type :roles

      attributes :id, :name
    end
  end
end
