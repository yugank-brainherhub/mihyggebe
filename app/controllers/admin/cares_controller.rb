# frozen_string_literal: true

class Admin::CaresController < ApplicationController
  before_action :authenticate_user!
  before_action :load_care, except: [:index]

  def index
    @cares = Care.select("cares.*, to_char(cares.created_at, 'YYYY-MM-DD HH24:MI:SS') as created_date")
                 .where.not(status: ['draft', 'pending', 'cancelled'])
    if params[:care].present?
      care_params = params.dig(:care)
      @cares = @cares.left_joins(:user).where('users.checkr_status = ?', care_params[:checkr_status].to_i) if care_params[:checkr_status].present?
      @cares = @cares.where(status: care_params[:status]) if care_params[:status].present?
      @cares = @cares.where(category: care_params[:category]) if care_params[:category].present?
    end
    @cares = @cares.includes(:user, :licences, :care_detail)
  end

  def licences
    @care     = Care.find(params[:id])
    @licences = @care.licences
  end

  def edit
    @care    = Care.find(params[:id])
    @comment = @care.comments.build
  end

  def update
    @care = Care.find(params[:id])
    if params.dig(:care, :comment, :description).present?
      @care.comments.build(description: params.dig(:care, :comment, :description), comment_type: params[:commit])
    end
    rejected = {}
    if params[:commit] == 'Reject'
      rejected = @care.cancel_care(params[:id])
    end
    return flash.now.alert = rejected if rejected.present? && rejected[:error].present?
    if @care.save
      flash.now.notice = I18n.t('care.saved')

      params[:commit] == 'Approve' ? @care.update(status: 'active') : @care.update(status: 'rejected')
      if params[:commit].present?
        UserMailer.send_status_update(@care.id, 0, @care&.user&.id, true).deliver_now
      end
    else
      flash.now.alert = @care.errors.full_messages.join(',')
    end
  end

  def cancel
    @care = Care.find(params[:id])
    unless @care.cancel_care(params[:id]).errors.present?
      if @care.update(status: 'rejected')
        UserMailer.send_status_update(care.id, amount_to_refund, current_user.id, false).deliver_now
      end
    end
      fail_with_error(422, :user, I18n.t('stripe.unsubscribe_fail')) if refund_status == false
  end

  private

  def load_care
    @care ||= Care.find(params[:id])
  end
end
