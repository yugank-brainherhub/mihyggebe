# frozen_string_literal: true

module API
  module V1
    class User::ChangePasswordAction < User::BaseAction
      def perform
        @success = update_password! if valid!
      end

      def valid!
        unless @record&.authenticate(permitted_params[:current_password])
          fail_with_error(422, :user, I18n.t('password.invalid_password'))
        end

        if permitted_params[:password] == permitted_params[:password_confirmation]
          return true
        end

        fail_with_error(422, :user, I18n.t('password.not_matched'))
      end

      def update_password!
        unless record.reset_password!(permitted_params[:password])
          fail_with_error(422, :user, record.errors)
        end
      end

      def data
        { msg: I18n.t('password.success') }
      end

      def self.policy_action
        :update?
      end
    end
  end
end
