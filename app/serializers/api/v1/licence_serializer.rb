# frozen_string_literal: true

module API
  module V1
    class LicenceSerializer < BaseSerializer
      include Rails.application.routes.url_helpers
      set_type :licences

      attributes :id, :licence_type, :name

      attribute :file_url do |object, _params|
        object.file.service_url if object.file.attachment
      end
    end
  end
end
