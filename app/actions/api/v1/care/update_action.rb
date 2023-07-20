# frozen_string_literal: true

module API
  module V1
    class Care::UpdateAction < Care::BaseAction
      def perform
        @success = update_record! if valid_record?
      end

      def valid_record?
        if permitted_params['care_detail_attributes'].present?
          rooms_count = permitted_params['care_detail_attributes']['no_of_rooms']
          beds_count = permitted_params['care_detail_attributes']['no_of_beds']
        end
        if  permitted_params["selected_services_attributes"].present?
          service_ids = []
          permitted_params["selected_services_attributes"].each{ |k,v| service_ids << v["service_id"]}
          bed_service_ids = record.beds.pluck(:service_id).compact
        end
        if record.cancelled? || (!current_user.admin? && record.subscription.present? && (Time.current - record.subscription.subscribed_at) > 72.hours &&
          %w[in-progress].include?(record.status))
          return fail_with_error(422, self.class.record_type, I18n.t('care.not_valid'))
        elsif rooms_count.present? &&  record.rooms.count > rooms_count.to_i
          return fail_with_error(422, self.class.record_type, I18n.t('care.care_room_error'))
        elsif beds_count.present? && record.beds.count > beds_count.to_i
          return fail_with_error(422, self.class.record_type, I18n.t('care.care_bed_error'))
        elsif service_ids.present? && !(bed_service_ids - service_ids.map(&:to_i)).empty?
          return fail_with_error(422, self.class.record_type, I18n.t('care.care_service_error'))
        end
        true
      end

      def update_record!
        params = permitted_params
        if params['licences_attributes'].present?
          params['licences_attributes'] = params['licences_attributes'].each { |_k, v| v.merge!(name: v['file']&.original_filename) }
        end
        return true if record.update(params)

        fail_with_error(422, self.class.record_type, record.errors)
      end

      def data
        API::V1::CareSerializer.new(record, params: { detail_type: params[:type], role: current_user.role.name})
      end

      def self.policy_action
        :update?
      end
    end
  end
end
