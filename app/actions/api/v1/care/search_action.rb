# frozen_string_literal: true

module API
  module V1
    class Care::SearchAction < Care::BaseAction
      include Actions::Pagination
      def perform
        @success = !records.nil?
      end

      def data
        API::V1::SearchSerializer.new(paginated_records, options)
      end

      def records
        if params[:request_page] == 'home_page'
          from = Date.today
          to = from + 15.days
          default_bed_no = 1
          care_ids_without_booked_rooms = find_care_without_booked_rooms(from, to, default_bed_no.to_i)
          #default_care = ::Care.includes(:bookings, rooms: :beds).distinct.active
          default_care = ::Care.includes(:bookings, rooms: :beds).where("county is not null and city is not null and state is not null") 
          #default_care = ::Care.joins(:services, :rooms)
          #                     .where(id: care_ids_without_booked_rooms)
          #                     .where('category = ?', 1)
          #                     .where('services.name = ?', 'Assisted Living')
          #                     .where('rooms.available_from <= ? AND rooms.available_to >= ?',
          #                            from, to).distinct.active
          return filterby_auto_search(default_care, params[:type],  params[:query])
        end

        default_care = ::Care.includes(:bookings, rooms: :beds)

        if params['location'].present? && params['category'].present? && params['care_types'].present? && params['checkin'].present? && params['checkout'].present? && params[:request_page] == 'result_page'
          #default_care = ::Care.includes(:bookings, rooms: :beds)
          #                     .where(id: find_care_without_booked_rooms(params[:checkin], params[:checkout], params[:bedsNo].to_i))
          #                     .active
          results = filterby_auto_search(default_care, params[:type], params[:location])
                    .filterby_category(params[:category])
          if params[:care_types].present?
            results = results.search_services_and_facilities(params[:care_types])
          end
          if params[:amenities].present?
            results = results.search_services_and_facilities(params[:amenities])
          end
          if params[:services].present?
            results = results.search_services_and_facilities(params[:services])
          end
          if params[:room_type].present?
            results = results.filterby_roomtype(params[:room_type])
          end
          if params[:bed_type].present?
            results = results.filterby_bedtype(params[:bed_type])
          end
          if params[:licence_type].present?
            results = results.filterby_licence(params[:licence_type])
          end
          if params[:max].present?
            results = results.filterby_price(params[:max], params[:min]).references(:room)
          end
          if params[:distance].present?
            results = results.filterby_distance(params[:distance])
          end
          if results
            return results
          else 
            return default_care
          end  
        else 
         return default_care
        end
        fail_with_error(422, self.class.record_type, I18n.t('care.query_absent'))
      end

      def filterby_auto_search(default_care, type, value)
        case type
        when 'state'
          default_care.where('lower(state) = ?', value.downcase)
        when 'county'
          default_care.where('lower(county) = ?', value.downcase)
        when 'city'
          default_care.where('lower(city) = ?', value.downcase)
        when 'zipcode'
          default_care.where('zipcode = ?', value)
        end
      end

      def find_care_without_booked_rooms(from, to, no_of_bed)
        available_rooms = ::Room.current_availability(::Room.ids, from, to).select do |room_id, availability|
          availability >= no_of_bed
        end.keys

        ::Room.where(id: available_rooms).pluck(:care_id)
      end

      def filtered_cares(queries)
        cares = []
        queries.each do |query|
          cares << ::Care.filterby_service(query)
        end
        care_ids = ::Care.find_by_sql(cares.join(' INTERSECT ')).uniq.pluck(:id)
        care_ids
      end

      def options
        @options = {}
        @options[:include] = include_param
        @options[:meta] = paginate_metadata
        @options[:params] = logged_user_cares
        @options
      end

      def wishlisted_cares
        records.joins(:wishlists).where('wishlists.user_id = ?', params[:user_id]).pluck(:id)
      end

      def logged_user_cares
        if params[:user_id].present?
          { cares: wishlisted_cares }
        else
          { cares: [] }
        end
      end

      def authorize!
        true
      end
    end
  end
end
