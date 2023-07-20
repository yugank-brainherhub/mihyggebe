# frozen_string_literal: true

module API
  module V1
    class User::BookingsAction < User::BaseAction
      include Actions::Pagination
      def perform
        return fail_with_error(422, :user, I18n.t('booking.invalid_status')) unless status_in_range?
        @success = !records.nil?
      end

      def data
        API::V1::BookingSerializer.new(paginated_records, options)
      end

      def records
        @records ||=  record.provider? ? providers_booking : ::Booking.customer_bookings(record)
        if record.customer? || record.social_worker?  
          @records = @records.active if params[:filter] == 'active'
          @records = @records.past if params[:filter] == 'past'
          @records = @records.cancelled if params[:filter] == 'cancelled'
        elsif record.provider?
          @records = @records.includes(:care).filter_by_category(params[:category]) if params[:category].present?
          @records = @records.filter_by_bookingId(params[:booking_id]) if params[:booking_id].present?
          @records = @records.includes(:care).filter_by_status(params[:status]) if params[:status].present?
        end
        return @records
      end

      def providers_booking
        ::Booking.provider_bookings(record).valid_provider_booking_status.order('bookings.created_at DESC')
      end

      def status_in_range?
        return %w[pending accepted rejected terminated].include?(params[:status]) if params[:status].present?
        true
      end

      def options
        @options = {}
        @options[:include] = include_param
        @options[:meta] = paginate_metadata
        @options
      end

      def authorize!
        true
      end
    end
  end
end
