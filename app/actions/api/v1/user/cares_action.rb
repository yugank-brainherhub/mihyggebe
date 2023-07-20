# frozen_string_literal: true

module API
  module V1
    class User::CaresAction < User::BaseAction
      include Actions::Pagination
      def perform
        @success = !records.nil?
      end

      def data
        API::V1::CareSlimSerializer.new(paginated_records, options)
      end

      def records
        @records ||= record.cares.includes(licences: :file_attachment).where(category: params[:category])
      end

      def options
        @options = {}
        @options[:include] = include_param
        @options[:meta] = paginate_metadata
        @options[:params] = { detail_type: params[:type] }
        @options
      end

      def authorize!
        true
      end
    end
  end
end
