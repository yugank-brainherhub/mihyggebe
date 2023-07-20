# frozen_string_literal: true

module API
  module V1
    class Asset::BaseAction < Abstract::BaseAction
      def self.record_class
        ::Asset
      end

      def scope
        @scope ||= ::Asset.all
      end

      def self.policy_class
        API::V1::AssetPolicy
      end

      def record
        @record ||= scope.find(params[:id])
      end

      def asset_params
        %w[id assetable_id assetable_type asset_type file sort]
      end

      def permitted_params
        params.require(:asset).permit(asset_params)
      end
    end
  end
end
