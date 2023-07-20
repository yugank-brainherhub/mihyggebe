# frozen_string_literal: true

module API
  module V1
    class CareSerializer < BaseSerializer
      include Rails.application.routes.url_helpers
      set_type :cares

      attributes :id,
                 :name,
                 :address1,
                 :address2,
                 :address3,
                 :fax_number,
                 :zipcode,
                 :county,
                 :country,
                 :state,
                 :board_members,
                 :category,
                 :status,
                 :user_id,
                 :map_url,
                 :city

      attribute :licences do |object, _params|
        object.licences&.map do |c|
          ::API::V1::LicenceSerializer.new(c)
        end
      end

      attribute :staff_details do |object, params|
        if params[:detail_type] == 'staff_details'
          object.staff_details.includes(:staff_role)&.map do |sd|
            ::API::V1::StaffDetailSerializer.new(sd)
          end
        end
      end

      attribute :care_details do |object, params|
        if params[:detail_type] == 'care_details'
          if object.care_detail.present?
            ::API::V1::CareDetailSerializer.new(object.care_detail)
          end
        end
      end

      attribute :selected_rooms do |object, params|
        if params[:detail_type] == 'care_details'
          object.selected_rooms.includes(:room_type)&.map do |sd|
            ::API::V1::RoomDetailSerializer.new(sd)
          end
        end
      end

      attribute :files do |object, params|
        if params[:detail_type] == 'care_details'
          object.assets&.order('sort ASC').map do |asset|
            ::API::V1::AssetSerializer.new(asset)
          end
        end
      end

      attribute :selected_services do |object, params|
        if params[:detail_type] == 'service_details'
          object.selected_services.includes(:service_type, :service)&.map do |ss|
            ::API::V1::ServiceDetailSerializer.new(ss)
          end
        end
      end

      attribute :selected_facilities do |object, params|
        if params[:detail_type] == 'facility_details'
          object.selected_facilities.includes(:facility_type, :facility)&.map do |sf|
            ::API::V1::FacilityDetailSerializer.new(sf)
          end
        end
      end

      attribute :room_details do |object, params|
        if params[:detail_type] == 'room_details'
          object.rooms.includes(:beds, :selected_room_services)&.map do |room|
            ::API::V1::RoomSerializer.new(room, params: { user: params[:role] })
          end
        end
      end
    end
  end
end
