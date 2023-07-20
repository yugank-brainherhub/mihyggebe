# frozen_string_literal: true

module API
  module V1
    class FacilityTypeSerializer < BaseSerializer
      set_type :facility_types

      attributes :id, :name

      attribute :facilities do |object, _params|
        object.facilities.order('name ASC')&.map do |c|
          {
            id: c.id,
            name: c.name
          }
        end
      end
    end
  end
end
