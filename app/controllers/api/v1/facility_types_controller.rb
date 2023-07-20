# frozen_string_literal: true

module Api
  module V1
    class FacilityTypesController < API::V1::ApplicationController
      # GET /service_types
      def index
        perform API::V1::FacilityType::IndexAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
