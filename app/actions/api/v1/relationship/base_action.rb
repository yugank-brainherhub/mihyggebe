# frozen_string_literal: true

module API
  module V1
    class Relationship::BaseAction < Abstract::BaseAction
      def self.record_class
        ::Relationship
      end

      def scope
        @scope ||= ::Relationship.all
      end

      def record
        @record ||= scope.find(params[:id])
      end

      def permitted_params
        params.require(:relationship).permit(:id, :name)
      end
    end
  end
end
