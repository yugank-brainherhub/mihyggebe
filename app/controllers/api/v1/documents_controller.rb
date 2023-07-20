# frozen_string_literal: true

module Api
  module V1
    class DocumentsController < API::V1::ApplicationController
      skip_before_action :authenticate_user!, only: %i[testing test]

      def signing
        perform API::V1::Document::SigningAction do
          return render json: @action.data, status: :ok
        end
        render_action_error @action
      end

      # TO-DO create actions for below
      def testing
        h = Hash.from_xml(request.body.read)
        DocusignJob.new(h, params[:id]).perform_now
        head :ok
      end

      def ds_return
        current_user.update_columns(docusign_status: 'in-progress')
        head :ok
      end

      def test
        render json: 'alive', status: :ok
      end
    end
  end
end
