# frozen_string_literal: true

module API
  module V1
    class Care::CreateAction < Care::BaseAction
      def self.policy_action
        :create?
      end

      def data
        API::V1::CareSerializer.new(record)
      end

      def perform
        @success = save_record!
      end

      def save_record!
        return true if record.save

        fail_with_error(422, self.class.record_type, record.errors)
      end

      def record
        params = permitted_params.merge(user_id: current_user.id, status: 'draft')
        if params['licences_attributes'].present?
          params['licences_attributes'] = params['licences_attributes'].each { |_k, v| v.merge!(name: v['file']&.original_filename) }
        end
        @record ||= self.class.record_class.new(params)
      end
    end
  end
end
