# frozen_string_literal: true

module Error
  module ErrorHandler
    def self.included(base)
      base.rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    end

    private

    def record_not_found(err = nil)
      errors = [{
        id: 'Not found',
        title: err&.message || 'Resource not found',
        status: 404
      }]
      render json: { errors: errors }, status: :not_found
    end
  end
end
