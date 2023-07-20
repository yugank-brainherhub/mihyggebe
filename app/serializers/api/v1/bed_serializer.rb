# frozen_string_literal: true

module API
  module V1
    class BedSerializer < BaseSerializer
      set_type :beds

      attributes :id, :bed_number, :bed_type

      attribute :service_name do |object, _params|
        object.service.name
      end
    end
  end
end
