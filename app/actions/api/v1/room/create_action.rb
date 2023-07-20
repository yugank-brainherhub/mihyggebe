# frozen_string_literal: true

module API
  module V1
    class Room::CreateAction < Room::BaseAction
      def self.policy_action
        :create?
      end

      def data
        API::V1::RoomSerializer.new(record)
      end

      def perform
        @success = save_record! if valid_record!
      end

      def save_record!
        return true if record.save

        fail_with_error(422, self.class.record_type, record.errors)
      end

      # Validate room - total beds in care should not be greater than beds allowed in care.
      def valid_record!
        if permitted_params["beds_attributes"].present?
          if total_beds > care.care_detail&.no_of_beds.to_i
            fail_with_error(422, self.class.record_type, { beds: I18n.t('bed.beds_not_allowed') })
          else
            return true
          end
        else 
          return true
        end
      end

      def care
        @care ||= ::Care.find(permitted_params[:care_id])
      end

      def new_beds
        @new_beds ||= permitted_params["beds_attributes"].values.count
      end

      def total_beds
        @total_beds ||= care.beds.size + new_beds
      end

      def record
        @record ||= self.class.record_class.new(permitted_params)
      end
    end
  end
end
