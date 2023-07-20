# frozen_string_literal: true

module API
  module V1
    module Admin
      class Password::CreateAction < Abstract::BaseAction
        attr_accessor :msg

        def user
          @user ||= ::User.find_by_email(params[:email])
        end

        def perform
          unless user
            return fail_with_error(422, :user, I18n.t('user.not_found', email: params[:email]))
          end

          call_emailer_and_messenger
        end

        def call_emailer_and_messenger
          user.generate_password_token!
          reset_pwd_using_email(user.reset_password_token)
        end

        def reset_pwd_using_email(token)
          if user.email.present?
            UserMailer.send_reset_pwd_instructions(user, token, false).deliver_now
          end
          @msg = I18n.t('email.sent')
        end

        def data
          { msg: msg }
        end

        def authorize!
          true
        end
      end
    end
  end
end
