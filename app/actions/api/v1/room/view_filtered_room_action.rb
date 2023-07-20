# frozen_string_literal: true

module API
  module V1
    class Room::ViewFilteredRoomAction < Room::BaseAction
      attr_accessor :rooms_available, :care, :availability

      # FIXME: N + 1 issues
      def perform
        find_care
       # return fail_with_error(422, :user, I18n.t('room.not_allowed'))# unless care.active?
       # return fail_with_error(422, :user, I18n.t('room.not_allowed'))# unless permitted_params[:no_of_beds].present?

        begin
          @rooms_available = find_rooms
        rescue StandardError => e
          return fail_with_error(422, :user, I18n.t('room.booking_unavailable'))
        end
        return fail_with_error(422, :user, I18n.t('room.out_range')) unless rooms_available.present?
      end

      def authorize!
        true
      end

      def find_care
        @care = ::Care.find(params[:care_id])
      end

      def find_rooms
        from = permitted_params[:from].to_datetime
        to = permitted_params[:to].to_datetime
        no_of_beds = permitted_params[:no_of_beds].to_i

        @availability = ::Room.current_availability(care.rooms.ids, from, to).select do |room_id, availability|
          availability >= no_of_beds
        end

        ::Room.where(care_id: params[:care_id])#.where(id: availability.keys)
      end


      def filter_rooms(rooms)
        if rooms.present?
          rooms.map do |room|
            assets = room .assets
            asset_url = (assets.first.file.service_url if assets.present?)
            { id: room.id,
              name: room.name,
              image_url: asset_url,
              price: room.price,
              room_type: room.room_type,
              bathroom_type: room.bathroom_type,
              no_of_beds: availability.dig(room.id) }
          end
        end
      end

      def permitted_params
        params.permit(:from, :to, :no_of_beds, :care_id)
      end

      def data
        { searched_rooms_detail: filter_rooms(rooms_available.compact),
          cares_detail: API::V1::ViewCareSerializer.new(care) }
      end
    end
  end
end
