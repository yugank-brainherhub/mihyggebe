# frozen_string_literal: true

module API
  module V1
    class SearchSerializer
      include FastJsonapi::ObjectSerializer
      set_type :cares
      set_key_transform :underscore

      attributes :id, :name

      attribute :provider_mobile do |care|
        care.user.mobile.to_s
      end

      attribute :provider_fb do |care|
        care.user.messenger.to_s
      end

      attribute :provider_gm do |care|
        care.user.google_meet_url.to_s
      end

      attribute :available_basic_facilities do |object, _params|
        available_facility_types_names = object.facilities.includes(:facility_type)
                                               .map(&:facility_type).map(&:name)
        available_facilities = object.facilities.map(&:name)
        { parking: object.room_types.map(&:name).include?('Parking Lot'),
          wifi: available_facilities.include?('WiFI'),
          meals: available_facility_types_names.include?('Meals'),
          security: available_facility_types_names.include?('24 Hours') }
      end

      attribute :address_details do |object, _params|
        { county: object.county,
          zipcode: object.zipcode,
          state: object.state,
          city: object.city,
          country: object.country,
          category: object.category,
          approx_distance: object.approx_distance,
          map_url: object.map_url }
      end

      attribute :licences do |object, _params|
        object.licences.map(&:licence_type).uniq
      end

      attribute :services do |object, _params|
        object.services.includes(:service_type)
              .where('service_types.available_for = ?', ::ServiceType.available_fors[object.category])
              .references(:service_type).map(&:name)
      end

      attribute :image_url do |object, _params|
        asset = object.assets.where('asset_type ILIKE (?)', '%image%').first
        asset.file&.service_url if asset&.file&.attachment
      end

      attribute :wishlisted do |object, params|
        params[:cares].include?(object.id)
      end
    end
  end
end
