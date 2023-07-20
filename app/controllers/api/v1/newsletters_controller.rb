# frozen_string_literal: true

module Api
  module V1
    class NewslettersController < API::V1::ApplicationController
      skip_before_action :authenticate_user!, only: %i[create]

      # POST /newsletters
      def create
        perform API::V1::Newsletter::CreateAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
