# frozen_string_literal: true

module API
  module V1
    class Newsletter::CreateAction < Abstract::BaseAction
      attr_accessor :newsletter

      def perform
        @success = add_email!
      end

      def add_email!
        @newsletter = ::Newsletter.new(email: permitted_params[:email])
        return true if @newsletter.save

        fail_with_error(422, :newsletter, newsletter.errors)
      end

      def permitted_params
        params.require(:newsletter).permit(:email)
      end

      def authorize!
        true
      end

      def data
        { msg: I18n.t('newsletter.success') }
      end
    end
  end
end
