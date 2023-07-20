# frozen_string_literal: true

module API
  module V1
    class CareDetailSerializer < BaseSerializer
      set_type :care_details

      attributes :id,
                 :description,
                 :area_description,
                 :no_of_rooms,
                 :no_of_beds,
                 :no_of_restrooms,
                 :no_of_bathrooms
    end
  end
end
