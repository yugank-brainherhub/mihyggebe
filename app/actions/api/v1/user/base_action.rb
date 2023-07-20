# frozen_string_literal: true

module API
  module V1
    class User::BaseAction < Abstract::BaseAction
      def self.record_class
        ::User
      end

      def scope
        @scope ||= ::User.all
      end

      def self.policy_class
        API::V1::UserPolicy
      end

      def record
        @record ||= scope.find(params[:id])
      end

      def permitted_params
        params.require(:user).permit(:first_name, :last_name, :email,
                                     :password, :messenger, :above18, :mobile, :role_id,
                                     :organization, :profession, :address,
                                     :password_confirmation, :current_password)
      end
    end
  end
end
