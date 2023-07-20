# frozen_string_literal: true

module API
  module V1
    class Room::ViewRoomAction < Room::BaseAction
      attr_accessor :room, :service_types
      def perform
        @room = record
        @service_types = room.selected_room_services.map(&:room_service_type).uniq
      end

      def data
        {
          room_assets: find_room_assets,
          room_detail: find_room_detail,
          bed_details: find_bed_details,
          services_categorised: categorise_services
        }
      end

      def find_room_assets
        assets = room.assets
        count = assets.count
        if assets.map(&:file).count > 0
          first_asset_url = assets.where('asset_type ILIKE (?)', '%video%').map(&:file).map(&:service_url)[0]
          rest_assets_url = assets.where('asset_type ILIKE (?)', '%image%').map(&:file).map(&:service_url)
          { first_asset_url: first_asset_url,
            rest_assets_url: rest_assets_url }
        end
      end

      def find_bed_details
        beds = room.beds.where.not(:service_id => 6)

        unless beds.nil?
          bed_detail = beds.map do |bed|
            { bed_number: bed.bed_number,
              bed_type: bed.bed_type,
              care_type: bed.service.name }
          end
        end
      end

      def find_room_detail
        { price: room.price,
          tax: tax_for_room,
          room_type: room.room_type,
          price_dec: room.price_desc }
      end

      def categorise_services
        room_services = RoomService.includes(:selected_room_services).where(selected_room_services: { room: room })
        service_under_type = service_types.map do |st|
          { st.name.to_s => room_services.where(room_service_type_id: st.id).map(&:name) }
        end
      end

      def tax_for_room
        care_state = room.care.state.upcase
        if state_tax_applicable?(care_state)
          state_tax_percent = fetch_tax_according_state(care_state)
          calculate_percent(room.price, state_tax_percent)
        end
      end

      def calculate_percent(value, percent)
        ans = (value * percent).to_f / 100
        return ans.round if ans < ans.round

        ans.round(2)
      end

      def fetch_tax_according_state(state)
        TAXES.fetch(state.to_sym)
      end

      def state_tax_applicable?(state)
        TAXES.include?(state.to_sym)
      end

      def authorize!
        true
      end
    end
  end
end
