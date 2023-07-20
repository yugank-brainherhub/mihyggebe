# frozen_string_literal: true

module API
  module V1
    class Password::UpdateAction < Abstract::BaseAction
      def perform
        token = params[:token].to_s
        user = ::User.find_by(reset_password_token: token)
        if token.blank? || user.nil?
          fail_with_error(422, :user, I18n.t('token.not_found'))
          return false
        end

        unless permitted_params[:password] == permitted_params[:password_confirmation]
          fail_with_error(422, :user, I18n.t('password.not_matched'))
          return false
        end

        if user.present? && user.password_token_valid?
          if user.reset_password!(permitted_params[:password])
            user.update(reset_password_token: nil)
          else
            fail_with_error(422, :user, user.errors)
          end
        else
          fail_with_error(422, :user, I18n.t('password.link_expired'))
          false
        end
      end

      def data
        { msg: I18n.t('password.success') }
      end

      def authorize!
        true
      end

      def permitted_params
        params.require(:user).permit(:password, :password_confirmation)
      end
    end
  end
end
