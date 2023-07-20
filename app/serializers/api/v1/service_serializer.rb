# frozen_string_literal: true

module API
  module V1
    class ServiceSerializer
      include FastJsonapi::ObjectSerializer
      set_type :services

      attributes :id

      attribute :name do |object|
        object.name == 'Parking Type - Free' ? 'Parking' : object.name
      end

      attribute :desc do |object|
        object.desc if object.class.name == 'Service'
      end
    end
  end
end
