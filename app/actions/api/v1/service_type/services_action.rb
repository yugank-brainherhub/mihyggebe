# frozen_string_literal: true

module API
  module V1
    class ServiceType::ServicesAction < ServiceType::BaseAction
      include Actions::Pagination
      def perform
        @success = !records.nil?
      end

      def data
        API::V1::ServiceSerializer.new(records)
      end

      def records
        @records ||= if params[:category] == 'senior_living'
          ::ServiceType.includes(:services).where(available_for: 'senior_living')
        else
          ::ServiceType.includes(:services).where(available_for: 'homeshare')
        end.map(&:services)
        if params[:category] != 'senior_living'
          @records << ::Facility.where(name: ['Direct Access to street or ground floor', 'Non-Smoking', 'Lift', 'Parking Type - Free', 'Personal pets allowed'])
        end
        @records.flatten.uniq
      end

      def authorize!
        true
      end
    end
  end
end
