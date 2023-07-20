# frozen_string_literal: true

module API
  module V1
    class CareSlimSerializer
      include FastJsonapi::ObjectSerializer
      set_key_transform :underscore
      set_type :cares

      attributes :id,
                 :name,
                 :address1,
                 :address2,
                 :address3,
                 :fax_number,
                 :zipcode,
                 :county,
                 :country,
                 :state,
                 :category,
                 :status,
                 :user_id,
                 :map_url,
                 :city

      attribute :image_url do |object, _params|
        asset = object.assets.where('asset_type ILIKE (?)', '%image%').first
        asset.file&.service_url if asset&.file&.attachment
      end

      attribute :can_update do |object, _params|
        if object.cancelled? || (object.subscription.present? && (Time.current - object.subscription.subscribed_at) > 72.hours &&
          object.user.pending? && %w[in-progress].include?(object.status))
          false
        elsif %w[draft pending active rejected cancelled].include?(object.status)
          true
        else
          true
        end
      end
    end
  end
end
