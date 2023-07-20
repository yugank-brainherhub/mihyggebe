# frozen_string_literal: true

module Api
  module V1
    class TaxesController < API::V1::ApplicationController
      skip_before_action :authenticate_user!, only: :index
      def index
        render json: TAXES.keys, status: :ok
      end
    end
  end
end