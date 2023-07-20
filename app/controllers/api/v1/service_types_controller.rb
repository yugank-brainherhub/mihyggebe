# frozen_string_literal: true

module Api
  module V1
    class ServiceTypesController < API::V1::ApplicationController
      skip_before_action :authenticate_user!, only: :services
      
      # GET /service_types
      def index
        perform API::V1::ServiceType::IndexAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # GET /service_types/services
      def services
        perform API::V1::ServiceType::ServicesAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
