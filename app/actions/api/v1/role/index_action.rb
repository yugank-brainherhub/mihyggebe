# frozen_string_literal: true

module API
  module V1
    class Role::IndexAction < Role::BaseAction
      include Actions::Pagination
      def perform
        @success = !records.nil?
      end

      def data
        API::V1::RoleSerializer.new(paginated_records, options)
      end

      def records
        @records ||= scope
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
