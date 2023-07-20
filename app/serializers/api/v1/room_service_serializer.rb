# frozen_string_literal: true

module API
  module V1
    class RoomServiceSerializer < BaseSerializer
      set_type :room_services

      attributes :id

      attribute :service do |object, _params|
        {
          name: object.room_service.name,
          id: object.room_service.id
        }
      end

      attribute :service_type do |object, _params|
        {
          name: object.room_service_type.name,
          id: object.room_service_type.id
        }
      end
    end
  end
end
