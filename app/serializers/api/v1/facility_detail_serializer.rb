# frozen_string_literal: true

module API
  module V1
    class FacilityDetailSerializer < BaseSerializer
      set_type :facility_details

      attributes :id

      attribute :name do |object, _params|
        object.facility.name
      end

      attribute :facility_type do |object, _params|
        object.facility_type.name
      end
    end
  end
end
