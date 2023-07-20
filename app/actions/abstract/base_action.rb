# frozen_string_literal: true

module Abstract
  class BaseAction < Uncouple::Action
    include Error::ExceptionHandler
    include JsonWebToken

    def self.record_class
      raise NotImplementedError
    end

    def self.record_type
      record_class.name.underscore.to_sym
    end

    def self.policy_action
      raise NotImplementedError
    end

    def self.permit_keys
      raise NotImplementedError
    end

    def self.policy_class; end

    def permitted_params
      raise NotImplementedError
    end

    def policy_record; end

    def authorize!
      return if !policy_record && !record

      Pundit.authorize(current_user,
                       policy_record || record,
                       self.class.policy_action,
                       policy_class: self.class.policy_class)
    end

    def authorize_without_record!
      Pundit.authorize(current_user,
                       self.class.record_class,
                       self.class.policy_action,
                       policy_class: self.class.policy_class)
    end

    def perform
      @success = save_record! if validate!
    end

    def validate!
      record.present?
    end

    def record
      raise NotImplementedError
    end

    def include_param
      return [] unless params[:include]

      Array(params[:include])[0].split(',').map(&:to_sym)
    end

    def save_record!
      record.assign_attributes(permitted_params)
      return true if record.save

      fail_with_error(422, self.class.record_type, record.errors)
    end
  end
end
