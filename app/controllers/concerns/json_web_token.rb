# frozen_string_literal: true

module JsonWebToken
  def encode_token(payload, expiration)
    payload[:exp] = expiration
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def decode_token(token)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.credentials.secret_key_base)[0])
  rescue StandardError
    nil
  end
end
