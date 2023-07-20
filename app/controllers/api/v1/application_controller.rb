# frozen_string_literal: true

class API::V1::ApplicationController < ActionController::API
  include API::Authentication
  include Error::ErrorHandler
  include ActionPerformer
  include JsonWebToken

  before_action :authenticate_user!
  attr_reader :current_user
end
