# frozen_string_literal: true

module API
  module V1
    class Care::ServicesAction < Care::BaseAction
      include Actions::Pagination
      def perform
        @success = !records.nil?
      end

      def data
        API::V1::ServiceSerializer.new(paginated_records, options)
      end

      def records
        @records ||= record.services.includes(:service_type)
                           .where('service_types.name =?', CARE_PROVIDED)
                           .references(:service_type)
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
