# frozen_string_literal: true

module API
  module V1
    class User::LoginAction < User::BaseAction
      def perform
        @success = verify_credentials!
      end

      def verify_credentials!
        record
        if @record.present?
          unless @record&.email_confirmed
            fail_with_error(422, :user, I18n.t('user.not_confirmed'))
          end
          return true #if @record&.authenticate(params[:password])

          fail_with_error(422, :user, I18n.t('user.password_error'))
        else
          fail_with_error(422, :user, I18n.t('user.not_found', email: params[:email]))
        end
      end

      def data
        {
          message: I18n.t('user.login_success', name: @record.first_name),
          auth_token: encode_token({ user_id: @record.id }, (Time.current + 2880.minutes).to_i),
          user: { id: @record.id,
                  email: @record.email,
                  first_name: @record.first_name,
                  last_name: @record.last_name,
                  mobile: record.mobile,
                  messengerId: record.messenger,
                  role: @record.role.name }
        }
      end

      def authorize!
        true
      end

      def record
        @record = ::User.find_by_email(params[:email])
      end
    end
  end
end
