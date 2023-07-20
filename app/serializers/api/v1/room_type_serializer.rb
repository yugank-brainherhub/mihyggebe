# frozen_string_literal: true

module API
  module V1
    class RoomTypeSerializer < BaseSerializer
      set_type :room_types

      attributes :id, :name
    end
  end
end
