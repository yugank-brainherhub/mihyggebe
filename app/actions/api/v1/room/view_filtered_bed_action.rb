# frozen_string_literal: true

module API
  module V1
    class Room::ViewFilteredBedAction < Room::BaseAction
      attr_accessor :room, :available_beds

      # FIXME: N + 1 issues
      def perform
        @room = record
        return fail_with_error(422, :user, I18n.t('room.not_allowed')) unless active_care?
        return fail_with_error(422, :user, I18n.t('room.not_allowed')) unless params_present?

        @available_beds = find_beds
      end

      def find_beds
        from = permitted_params[:from].to_datetime
        to = permitted_params[:to].to_datetime

        begin
          blocked_beds = ::Room.blocked_beds
        rescue StandardError => e
          return fail_with_error(422, :user, I18n.t('room.booking_unavailable'))
        end

        availability = ::Room.current_availability([room.id], from, to)

        return nil if availability[room.id].to_i < permitted_params[:no_of_beds].to_i

        beds_with_booking = room.bookings
                                .bookings_in_range(from, to)
                                .joins(:bed_bookings)
                                .pluck('bed_bookings.bed_id')

        ::Bed.includes(:service).left_joins(:bookings).where(room_id: room.id)
             .where.not(id: blocked_beds + beds_with_booking).distinct
      end

      def params_present?
        permitted_params[:from].present? && permitted_params[:to].present?
      end

      def active_care?
        room.care.active?
      end

      def data
        unless available_beds.nil?
          filter_beds(available_beds.compact)
        end
      end

      def filter_beds(available_beds)
        if available_beds.present?
          available_beds.map do |bed|
            { id: bed.id,
              bed_number: bed.bed_number,
              bed_type: bed.bed_type,
              care_type: bed.service.name }
          end
        end
      end

      def permitted_params
        params.permit(:from, :to, :no_of_beds, :room_id)
      end

      def scope
        @scope ||= ::Room.all
      end

      def record
        @record ||= scope.find(permitted_params[:room_id])
      end

      def authorize!
        true
      end
    end
  end
end
