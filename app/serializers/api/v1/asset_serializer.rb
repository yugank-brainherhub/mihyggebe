# frozen_string_literal: true

module API
  module V1
    class AssetSerializer < BaseSerializer
      include Rails.application.routes.url_helpers
      set_type :assets

      attributes :id, :asset_type, :assetable_id, :assetable_type, :file_url, :sort

      attribute :file_url do |object|
        object.file&.service_url if object.file.attachment && !Rails.env.test?
      end
    end
  end
end
