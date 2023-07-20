# frozen_string_literal: true

module API
  module V1
    class ViewCareSerializer < BaseSerializer
      include FastJsonapi::ObjectSerializer
      set_type :cares
      set_key_transform :underscore

      attribute :care_assets do |object, _params|
        assets = object.assets.order('sort ASC')
        count = assets.count
        if assets.map(&:file).count > 0
          first_asset_url = assets.where('asset_type ILIKE (?)', '%video%').map(&:file).map(&:service_url)[0]
          rest_assets_url = assets.where('asset_type ILIKE (?)', '%image%').map(&:file).map(&:service_url)
          { first_asset_url: first_asset_url,
            rest_assets_url: rest_assets_url }
        end
      end

      attribute :care_detail do |object, _params|
        care_detail = object.care_detail
        provider = object.user

        { name: object.name,
          board_members: object.board_members,
          county: object.county,
          city: object.city,
          category: object.category,
          care_detail_facilities: object.selected_rooms.map(&:room_type).map(&:name),
          approx_distance: object.approx_distance,
          map_url: object.map_url,
          description: care_detail.description,
          provider_mobile: provider.mobile.to_s,
          provider_fb: provider.messenger.to_s,
          provider_fb: provider.google_meet_url.to_s,
          area_description: care_detail.area_description }
      end

      attribute :available_basic_facilities do |object, _params|
        available_facility_types_names = object.facilities.includes(:facility_type).map(&:facility_type).map(&:name)
        available_facilities = object.facilities.map(&:name)
        { parking: object.room_types.map(&:name).include?('Parking Lot'),
          wifi: available_facilities.include?('WiFI'),
          meals: available_facility_types_names.include?('Meals'),
          security: available_facility_types_names.include?('24 Hours') }
      end

      attribute :care_room_details do |object, params|
        care_rooms = object.rooms
        care_rooms.map do |room|
          assets = room.assets
          if assets.present?
            asset_url = assets.where('asset_type ILIKE (?)', '%image%').map(&:file).map(&:service_url)[0]
          end
          left = params[:count][room.id] if params[:count].present?
          { id: room.id,
            name: room.name,
            image_url: asset_url,
            price: room.price,
            room_type: room.room_type,
            bathroom_type: room.bathroom_type,
            no_of_beds: room.beds_count,
            beds_left: left}
        end
      end

      attribute :facility_categorised do |object, _params|
        available_facility_types = object.facilities.includes(:facility_type).map(&:facility_type).uniq

        care_facilities = Facility.includes(:selected_facilities).where(selected_facilities: { care: object })
        available_facility_types.map do |facility_type|
          { facility_type.name.to_s => care_facilities.where(facility_type_id: facility_type.id).map(&:name) }
        end
      end

      attribute :services_categorised do |object, _params|
        available_service_types = object.services.includes(:service_type).map(&:service_type).uniq

        care_services = Service.includes(:selected_services).where(selected_services: { care: object })
        available_service_types.map do |service_type|
          { service_type.name.to_s => care_services.where(service_type_id: service_type.id).map(&:name) }
        end
      end

      attribute :staff_details do |object, _params|
        staff_details = object.staff_details.includes(:staff_role)
        staff_details.map do |detail|
          { name: detail.name,
            staff_role: detail.staff_role.name }
        end
      end

      attribute :wishlisted do |object, params|
        object.wishlists.pluck(:user_id).include?(params[:user_id])
      end
    end
  end
end
