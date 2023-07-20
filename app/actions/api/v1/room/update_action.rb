# frozen_string_literal: true

module API
  module V1
    class Room::UpdateAction < Room::BaseAction
      def perform
        @success = update_record! if valid_record!
      end

      def update_record!
        if  record.any_active_bookings
          if permitted_params["selected_room_services_attributes"].present? && permitted_params["selected_room_services_attributes"].each { |k, v| break true if v["_destroy"]  == 'true' } == true
            return fail_with_error(422, self.class.record_type, I18n.t('room.room_service_error'))
          end
          if permitted_params["beds_attributes"].present? && permitted_params["beds_attributes"].each { |k, v| break true if v["_destroy"]  == 'true' } == true
            return fail_with_error(422, self.class.record_type, I18n.t('room.bed_error'))
          end
        end
        return true if record.update(permitted_params)

        fail_with_error(422, self.class.record_type, record.errors)
      end

      def valid_record!
        if permitted_params["beds_attributes"].present?
          if total_beds > ::Room.room_types[room_type]
            fail_with_error(422, self.class.record_type, { beds: I18n.t('room.invalid_beds')})
          elsif beds_in_care > record.care&.care_detail&.no_of_beds.to_i
            fail_with_error(422, self.class.record_type, { beds: I18n.t('bed.beds_not_allowed')})
          else
            return true
          end
        else
          return true
        end

      end

      def beds_to_destroy
        @beds_to_destroy ||= permitted_params["beds_attributes"].select { |_, value| value["_destroy"] }.values.pluck(:id)
      end

      def beds_to_add
        @beds_to_add ||= permitted_params["beds_attributes"].select { |_, value| value["id"].nil? }.values.count
      end

      def total_beds
        @total_beds ||= record.beds.where.not(id: beds_to_destroy).count +  beds_to_add
      end


      def room_type
        @room_type ||= permitted_params["room_type"].present? ? permitted_params["room_type"] : record.room_type
      end

      def beds_in_care
        @beds_in_care ||= (record.care.beds.pluck(:id)-beds_to_destroy.collect(&:to_i)).count + beds_to_add
      end

      def data
        API::V1::RoomSerializer.new(record)
      end

      def self.policy_action
        :update?
      end
    end
  end
end
