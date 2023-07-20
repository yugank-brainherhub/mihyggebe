# frozen_string_literal: true

module API
  module V1
    class RoomServiceTypeSerializer < BaseSerializer
      set_type :room_service_types

      attributes :id, :name

      attribute :room_services do |object, _params|
        object.room_services.order('name ASC')&.map do |c|
          {
            id: c.id,
            name: c.name
          }
        end
      end
    end
  end
end
