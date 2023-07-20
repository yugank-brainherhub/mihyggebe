# frozen_string_literal: true

module API
  module V1
    class RoomSerializer < BaseSerializer
      include Rails.application.routes.url_helpers
      set_type :rooms

      attributes :id,
                 :room_type,
                 :bathroom_type,
                 :name,
                 :price_desc,
                 :available_from,
                 :available_to

      attribute :beds do |object, _params|
        object.beds.includes(:service).map do |c|
          ::API::V1::BedSerializer.new(c)
        end
      end

      attribute :files do |object, params|
        object.assets&.order('sort ASC').map do |asset|
          ::API::V1::AssetSerializer.new(asset)
        end
      end

      attribute :available_from do |object, _params|
        object.available_from&.strftime('%m/%d/%Y')
      end

      attribute :price do |object, _params|
        object.price&.to_i&.to_s
      end

      attribute :available_to do |object, _params|
        object.available_to&.strftime('%m/%d/%Y')
      end

      attribute :selected_room_services do |object, _params|
        object.selected_room_services.includes(:room_service_type, :room_service).map do |sf|
          ::API::V1::RoomServiceSerializer.new(sf)
        end
      end

      attribute :no_of_beds_allowed do |object, _params|
        beds = object.care&.care_detail&.no_of_beds
        beds.present? ? beds.to_i - object.care.beds.size : 0
      end

      attribute :has_booking do |object, params|
        object.any_active_bookings if params[:user] == 'provider'
      end
    end
  end
end
