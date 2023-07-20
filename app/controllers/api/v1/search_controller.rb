# frozen_string_literal: true

module Api
  module V1
    class SearchController < API::V1::ApplicationController
      skip_before_action :authenticate_user!

      def autocomplete
        perform API::V1::Search::AutocompleteAction do
          return render json: @action.data
        end

        render_action_error @action
      end
    end
  end
end
