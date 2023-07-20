# frozen_string_literal: true

class Admin::ProvidersController < ApplicationController
  before_action :authenticate_user!

  def index
    @providers = Role.provider.users.select("users.*, to_char(users.created_at, 'YYYY-MM-DD HH24:MI:SS') as created_date")
  end

  def edit
    @provider = User.find(params[:id])
    @comment = @provider.comments.build
  end

  def update
    @provider = User.find(params[:id])
    if params.dig(:user, :comment, :description).present?
      @provider.comments.build(description: params.dig(:user, :comment, :description), comment_type: params[:commit])
      @provider.save
    end

    if params[:commit] == 'Approve'
      @provider.approved!
      # UserMailer.provider_status_mail(@provider.id).deliver_now work on this to send bank details mail
    else
      @provider.cares.each do |care|
        care.cancel_care(care.id)
        care.update(status: 'rejected')
      end
      begin
        checker_pan = Plan.find_by(min: -25, max: -25).planId
        checkr_subscription = @provider.subscriptions.find_by(planId: checker_pan)
        Stripe::Subscription.delete(checkr_subscription.subscriptionId)
      rescue StandardError => e
        flash.now.alert = I18n.t('stripe.admin_error')
      end
      @provider.rejected!
    end
    UserMailer.provider_status_mail(@provider.id).deliver_now
  end

  def update_docusign
    @provider = User.find(params[:id])
    if @provider.update(docusign_status: 'Completed')
      flash.now.alert = I18n.t('user.docusign')
      UserMailer.docusign_status_mail(@provider.id).deliver_now
    end
  end


  def send_bankdetails_mail
    @provider = User.find(params[:id])
    UserMailer.provider_status_mail(@provider.id).deliver_now if @provider.approved?
  end
end
