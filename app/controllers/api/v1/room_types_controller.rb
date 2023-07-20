# frozen_string_literal: true

module Api
  module V1
    class RoomTypesController < API::V1::ApplicationController
      skip_before_action :authenticate_user!
      # GET /universities
      def index
        perform API::V1::RoomType::IndexAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
