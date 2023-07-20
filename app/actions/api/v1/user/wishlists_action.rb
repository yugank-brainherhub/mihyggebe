# frozen_string_literal: true

module API
  module V1
    class User::WishlistsAction < User::BaseAction
      include Actions::Pagination
      def perform
        @success = !records.nil?
      end

      def data
        API::V1::SearchSerializer.new(paginated_records, options)
      end

      def records
        @records ||= record.wlcares
      end

      def options
        @options = {}
        @options[:include] = include_param
        @options[:meta] = paginate_metadata
        @options[:params] = { cares: [] }
        @options
      end

      def authorize!
        true
      end
    end
  end
end
