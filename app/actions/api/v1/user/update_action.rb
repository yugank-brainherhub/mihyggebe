# frozen_string_literal: true

module API
  module V1
    class User::UpdateAction < User::BaseAction
      def perform
        @success = update_user!
      end

      def data
        API::V1::UserSerializer.new(record, options)
      end

      def update_user!
        return true if record.update(params_acording_user)

        fail_with_error(422, :user, record.errors)
      end

      def authorize!
        true
      end

      def params_acording_user
        return permitted_params if record.provider? || record.customer?
        return social_worker_permitted_params if record.social_worker?
      end

      def permitted_params
        params.require(:user).permit(:first_name, :last_name, :messenger, :mobile, :google_meet_url)
      end

      def social_worker_permitted_params
        params.require(:user).permit(:first_name, :last_name,
                                     :messenger, :mobile, :google_meet_url,
                                     :organization, :profession, :address)
      end

      def options
        @options = {}
        @options[:include] = include_param
        @options
      end
    end
  end
end
