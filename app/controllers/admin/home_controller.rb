# frozen_string_literal: true

class Admin::HomeController < ApplicationController
  def index
    redirect_to login_path unless current_user
  end
end
