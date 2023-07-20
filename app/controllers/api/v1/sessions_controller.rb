# frozen_string_literal: true

class Api::V1::SessionsController < API::V1::ApplicationController
  skip_before_action :authenticate_user!

  def destroy
    BlacklistToken.create(token: http_token)

    head :ok
  end
end
