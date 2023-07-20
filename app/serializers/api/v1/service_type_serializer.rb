# frozen_string_literal: true

module API
  module V1
    class ServiceTypeSerializer < BaseSerializer
      set_type :service_types

      attributes :id, :name, :available_for

      attribute :services do |object, _params|
        object.services.order('name ASC')&.map do |c|
          {
            id: c.id,
            name: c.name,
            desc: c.desc
          }
        end
      end
    end
  end
end
