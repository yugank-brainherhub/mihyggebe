# frozen_string_literal: true

module API
  module V1
    class Care::BaseAction < Abstract::BaseAction
      def self.record_class
        ::Care
      end

      def scope
        @scope ||= ::Care.all
      end

      def self.policy_class
        API::V1::CarePolicy
      end

      def record
        @record ||= scope.find(params[:id])
      end

      def licence_params
        { licences_attributes: %w[licence_type file name id _destroy] }
      end

      def staff_params
        { staff_details_attributes: %w[id name staff_role_id _destroy] }
      end

      def care_detail_params
        { care_detail_attributes: %w[id description area_description no_of_beds no_of_bathrooms
                                     no_of_restrooms no_of_rooms _destroy] }
      end

      def room_params
        { selected_rooms_attributes: %w[id room_type_id _destroy] }
      end

      def service_params
        { selected_services_attributes: %w[id name service_type_id service_id _destroy] }
      end

      def facility_params
        { selected_facilities_attributes: %w[id name facility_type_id facility_id _destroy] }
      end

      def care_params
        %w[name address1 address2 address3 county country state zipcode fax_number
           board_members category status user_id city]
      end

      def permitted_params
        params.require(:care).permit(care_params, licence_params, staff_params, care_detail_params,
                                     room_params, service_params, facility_params)
      end
    end
  end
end
