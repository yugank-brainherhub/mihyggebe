# frozen_string_literal: true

module API
  module V1
    class Asset::CreateAction < Asset::BaseAction
      include Actions::Pagination

      def perform
        if params[:assets].present?
          assets = params[:type] == 'update' ? update_assets(params[:assets]) : create_assets(params[:assets])
          save_assets(assets) if assets.present?
        else
          fail_with_error(422, assetable.class.to_s.to_sym, error: I18n.t('asset.blank_error'))
        end
      end

      def data
        if params[:type] == 'update'
          {
            files_created: (@records.present? ? API::V1::AssetSerializer.new(@records.flatten.sort_by{ |e| e.sort }) : {}),
            files_failed: @failed.present? ? @failed.map { |f| [{ id: f&.id, name: f&.name, errors: f.errors }] } : {}
          }
        else
          API::V1::AssetSerializer.new(@records.flatten)
        end
      end

      def assetable
        if params[:assetable_type] == 'care' 
         parent = ::Care  
         return parent.find(params[:assetable_id])
        end  
        if params[:assetable_type] == 'room'   
         parent = ::Room 
         return parent.find(params[:assetable_id])
        end
        if params[:assetable_type] == 'booking'   
         parent = ::Booking
         return parent.find_by_bookingID(params[:assetable_id])
        end
        
      end

      def create_assets(assets)
        content_types = assets.map(&:content_type)
        if assetable.assets.count > 1
          return fail_with_error(422, assetable.class.to_s.to_sym, error: I18n.t('asset.already_uploaded_error'))
        elsif params[:assets].count <= 2 && content_types.select { |s| s.include?('image') }.count == 1
          assets = assets.map do |asset|
            { file: asset,
              asset_type: asset.content_type,
              sort: 1,
              name: asset.original_filename }
          end
          return assets
        else
          return fail_with_error(422, assetable.class.to_s.to_sym, error: I18n.t('asset.create_error'))
        end
      end

      def update_assets(assets)
        assets = assets.values.map do |asset|

          { id: asset['id'],
            sort: asset['sort'] }.merge(
              asset['file'].present? ?
              { file: asset['file'],
                asset_type: asset['file'].content_type,
                name: asset['file'].original_filename } :
              {}
            )
        end
        return assets
      end

      def save_assets(assets)
        @failed = []
        @records = []
        ::Asset.where(id: assets.map{|s| s[:id]}&.compact).update_all(sort: nil)
        assets.each do |asset|
          if asset[:id].present?
            file = assetable.assets.where(id: asset[:id]).first
          end
          if file.present?
            file.update(sort: nil)
            file.update(asset.except(:id)) ? @records << file : @failed << file
          else
            file =  assetable.assets.new(asset)
            file.save ? @records << file : @failed << file
          end
        end
        @records
      end

      def self.policy_action
        :create?
      end

      def authorize!
        true
      end
    end
  end
end
