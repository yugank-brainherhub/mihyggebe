# frozen_string_literal: true

module Api
  module V1
    class RelationshipsController < API::V1::ApplicationController
      skip_before_action :authenticate_user!

      # GET /relationships
      def index
        perform API::V1::Relationship::IndexAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # POST /api/relationships
      def create
        perform API::V1::Relationship::CreateAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
