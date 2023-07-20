# frozen_string_literal: true

module API
  module V1
    class RoomDetailSerializer < BaseSerializer
      set_type :room_details

      attributes :id

      attribute :room_type do |object, _params|
        object.room_type.name
      end
    end
  end
end
