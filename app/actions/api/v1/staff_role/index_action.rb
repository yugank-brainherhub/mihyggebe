# frozen_string_literal: true

module API
  module V1
    class StaffRole::IndexAction < StaffRole::BaseAction
      include Actions::Pagination
      def perform
        @success = !records.nil?
      end

      def data
        API::V1::StaffRoleSerializer.new(paginated_records, options)
      end

      def records
        @records ||= scope.order('name ASC')
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
