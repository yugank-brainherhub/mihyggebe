# frozen_string_literal: true

class API::V1::Billing::SetCarePlanAction < Abstract::BaseAction
 
  attr_accessor :care, :status

  def perform
   
    @care = Care.where(:status => 1).where(user: current_user).where(:id => params[:billing][:care_id]).last
    if @care
      @care.update_attribute("plan_id", params[:billing][:plan_id])
      @status = true
    else 
      @status = false
    end  
    @success = true
  end


  def data
    { status: status, #current_user.first_time,
      details: care }
  end

  

  def authorize!
    true
  end
end
