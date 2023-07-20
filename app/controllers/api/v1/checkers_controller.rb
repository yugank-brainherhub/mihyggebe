# frozen_string_literal: true

module Api
  module V1
    class CheckersController < API::V1::ApplicationController
      skip_before_action :authenticate_user!, only: %i[event_handler]

      def event_handler
        checkr_signature = request.headers[:HTTP_X_CHECKR_SIGNATURE]
        data = request.body.string
        hash_digest = 'SHA256'
        signature_to_match = OpenSSL::HMAC.hexdigest(hash_digest, DEFAULTS[:checker_key], data)
        params.merge!(checkr_signature: checkr_signature, signature_to_match: signature_to_match)
        perform API::V1::Checker::EventHandlerAction do
          return render json: @action.data, status: :ok
        end

        head :ok
      end

      def create_candidate
        perform API::V1::Checker::CreateCandidateAction do
          return render json: @action.data, status: :ok
        end
      end
    end
  end
end
