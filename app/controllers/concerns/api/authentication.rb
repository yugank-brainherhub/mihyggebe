# frozen_string_literal: true

module API
  module Authentication
    include JsonWebToken
    def self.included(base)
      base.rescue_from Pundit::NotAuthorizedError, with: :access_forbidden
    end

    def authenticate_user!
      unless BlacklistToken.find_by(token: http_token).nil?
        raise JWT::VerificationError
      end

      unless user_id_in_token?
        user_not_authorized
        return
      end
      @current_user = User.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
      user_not_authorized
    end

    def user_not_authorized
      errors = {
        id: 'user not authorized',
        title: 'User not signed in',
        status: 401
      }
      render json: { errors: errors }, status: 401
    end

    def access_forbidden
      errors = {
        id: 'user not permitted to access resource',
        status: 403
      }
      render json: { errors: errors }, status: 403
    end

    def http_token
      if request.headers['Authorization'].present?
        @http_token ||= request.headers['Authorization'].split(' ').last
      end
    end

    def auth_token
      @auth_token ||= decode_token(http_token)
    end

    def user_id_in_token?
      http_token && auth_token && auth_token[:user_id].to_i
    end
  end
end
