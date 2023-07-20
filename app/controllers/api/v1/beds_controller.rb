# frozen_string_literal: true

module Api
  module V1
    class BedsController < API::V1::ApplicationController
      skip_before_action :authenticate_user!

      # POST /Beds
      def hold
        perform API::V1::Bed::HoldAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
