# frozen_string_literal: true

module API
  module V1
    class User::CreateAction < User::BaseAction
      def perform
        @success = add_user!
      end

      def data
        { msg: I18n.t('user.confirm_email') }
      end

      def add_user!
        if record.save
          UserMailer.registration_confirmation(record).deliver_now
          return true
        end
        fail_with_error(422, :user, record.errors)
      end

      def record
        @record ||= self.class.record_class.new(permitted_params)
      end

      def authorize!
        true
      end
    end
  end
end
