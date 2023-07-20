class Admin::CommentsController < ApplicationController
  before_action :load_provider

  def index
    @comments = @provider.comments.order('created_at DESC')
  end

  private

  def load_provider
    @provider = User.find(params[:provider_id])
  end
end
