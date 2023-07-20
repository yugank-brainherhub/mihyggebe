# frozen_string_literal: true

module API
  module V1
    class BaseSerializer
      include FastJsonapi::ObjectSerializer

      # set_key_transform :dash

      def serializable_hash
        data = super[:data]
        return {} if data.nil?
        return data.map { |r| r[:attributes] } if collection?(data)

        data[:attributes]
      end

      def to_json(_opts)
        serialized_json
      end

      def as_json(_options = nil)
        serializable_hash
      end

      def collection?(data)
        data.respond_to?(:size) && !data.respond_to?(:each_pair)
      end
    end
  end
end
