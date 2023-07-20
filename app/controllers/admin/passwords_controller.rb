# frozen_string_literal: true

class Admin::PasswordsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.generate_password_token!
      if user.email.present?
        UserMailer.send_reset_pwd_instructions(user, user.reset_password_token, true).deliver_now
      end
      flash[:notice] = I18n.t('email.sent')
      redirect_to new_admin_password_path
    else
      flash[:notice] = I18n.t('user.not_found', email: params[:email])
      redirect_to new_admin_password_path
    end
  end

  def edit
    @user = User.where('reset_password_token LIKE :query OR id LIKE :query', query: params[:id]).first
  end

  def update
    @user = User.where('reset_password_token LIKE :query OR id LIKE :query', query: params[:id]).first
    if !@user.password_token_valid? && params[:id].to_s.length > 1
      flash[:notice] = I18n.t('password.link_expired')
      redirect_to new_admin_password_path
    elsif user_params[:password] != user_params[:password_confirmation]
      flash[:notice] = I18n.t('password.not_matched')
      redirect_to edit_admin_password_path(params[:id])
    elsif @user.reset_password!(user_params[:password])
      flash[:notice] = I18n.t('password.success')
      redirect_to new_admin_session_path
    else
      render :edit
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
