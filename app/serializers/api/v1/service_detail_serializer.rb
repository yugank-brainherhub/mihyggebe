# frozen_string_literal: true

module API
  module V1
    class ServiceDetailSerializer < BaseSerializer
      set_type :service_details

      attributes :id

      attribute :name do |object, _params|
        object.service.name
      end

      attribute :service_type do |object, _params|
        object.service_type.name
      end
    end
  end
end
