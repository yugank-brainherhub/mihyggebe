# frozen_string_literal: true

module API
  module V1
    class User::ConfirmEmailAction < User::BaseAction
      def perform
        @success = activate_user_account!
      end

      def data
        { msg: I18n.t('user.email_verified') }
      end

      def activate_user_account!
        if record
          return true if record.activate_email
        end
        fail_with_error(422, :user, I18n.t('user.not_exist'))
      end

      def record
        @record ||= scope.find_by(confirm_token: params[:id])
      end

      def authorize!
        true
      end
    end
  end
end
