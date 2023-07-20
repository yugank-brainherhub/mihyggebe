# frozen_string_literal: true

class Admin::SessionsController < ApplicationController
  def new
  
  end

  def create
    user = User.where(email: params[:email], role: Role.admin).first
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in!'
      redirect_to root_url
    else
      flash.now[:error] = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out!'
    redirect_to root_url
  end
end
