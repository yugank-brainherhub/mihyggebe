# frozen_string_literal: true

module API
  module V1
    class WishlistSerializer < BaseSerializer
      include FastJsonapi::ObjectSerializer
      set_key_transform :underscore
      set_type :wishlists

      attributes :id

      attribute :care do |object, _params|
        care = object.care
        available_facility_types_names = care.facilities.includes(:facility_type)
                                             .map(&:facility_type).map(&:name)
        available_facilities = care.facilities.map(&:name)
        asset = care.assets.where('asset_type ILIKE (?)', '%image%').first
        { 
          id: object.id,
          care_id: object.care_id,
          care_name: care.name,
          basic_facilities: {
            parking: care.room_types.map(&:name).include?('Parking Lot'),
            wifi: available_facilities.include?('WiFI'),
            meals: available_facility_types_names.include?('Meals'),
            security: available_facility_types_names.include?('24 Hours')
          },
          address_details: 
            { county: care.county,
              zipcode: care.zipcode,
              state: care.state,
              city: care.city,
              country: care.country,
              category: care.category,
              approx_distance: care.approx_distance,
              map_url: care.map_url 
            },
          licence_types: care.licences.map(&:licence_type).uniq,
          image_url: asset&.file&.service_url
        }
      end
    end
  end
end
