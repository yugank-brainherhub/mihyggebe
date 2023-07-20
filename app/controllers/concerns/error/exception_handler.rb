# frozen_string_literal: true

module Error
  module ExceptionHandler
    def send_hash_messages
      @send_hash_messages ||= false
    end

    def formatted_errors
      send_hash_messages ? errors : flatten_error_messages
    end

    def error_code
      @error_code ||= 400
    end

    def errors
      @errors ||= {}
    end

    def success?
      errors.blank?
    end

    def flatten_error_messages
      errors.map do |_key, error_object|
        if error_object.respond_to?(:full_messages)
          [formatted_error_messages(error_object.messages)]
        elsif error_object.is_a?(Hash)
          [error_object]
        elsif error_object.is_a?(Array) || error_object.is_a?(String)
          [error_object]
        end
      end.compact.flatten
    end

    def error_messages
      Hash[errors.map do |key, error_object|
        if error_object.respond_to?(:full_messages)
          [key, formatted_error_messages(error_object.messages)]
        elsif error_object.is_a?(Hash)
          [key, error_object.values]
        elsif error_object.is_a?(Array) || error_object.is_a?(String)
          [key, error_object]
        end
      end.compact]
    end

    private

    def add_send_hash_messages(val = true)
      @send_hash_messages = val
    end

    def fail_with_error(error_code, key, reason)
      self.error_code = error_code
      append_error(key, reason)
      nil # return nil explictly
    end

    def formatted_error_messages(messages)
      messages
    end

    def inherit_errors(action)
      self.error_code = action.error_code
      errors.merge!(action.errors)
    end

    def error_code=(code)
      @error_code = code
    end

    def append_error(key, value)
      if value.is_a?(Hash)
        errors[key] ||= {}
        errors[key].merge!(value)
      else
        errors[key] = value
      end
    end
  end
end
