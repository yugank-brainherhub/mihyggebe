# frozen_string_literal: true

class API::V1::Billing::ViewSubscriptionAction < Abstract::BaseAction
  attr_accessor :care_details

  def perform
    @care_details = CareDetail.cares_ready_for_subscription(current_user)
    @care = Care.includes(:care_detail, subscription: %i[plans packages]).where(user: current_user)
    if @care.present?
      @care_details = []
      @care.map do |care|
        if care.care_detail.present? && !care.draft? && !care.cancelled?
          if !care.pending?
          @care_details <<  { care_id: care.id,
              status: care.status,
              name: care.name,
              bed: care.care_detail.no_of_beds,
              taxes: TAXES.dig(care.state.upcase.to_sym).to_f,
              **plan_active(care) }
          else
            @care_details << retrieve_care_detail(care)
            @care_details << retrieve_care_detail_last(care)
          end
        end
      end
    end
    @success = true
  end

  def plan_active(care)
    { active_plan: ::Plan.joins(:subscriptions).where('subscriptions.care_id = ?', care.id).where('plans.min > ?', -35),
      plan_validity: "#{care.subscription.created_at.to_date} / #{care.subscription.created_at.to_date + 1.year}" }
  end

  def data
    { first_time: false, #current_user.first_time,
      details: care_details.compact }
  end

  def retrieve_care_detail(care)
    { care_id: care.id,
      status: care.status,
      taxes: TAXES.dig(care.state.upcase.to_sym).to_f,
      name: care.name,
      bed: care.care_detail.no_of_beds,
      applicable_plan: Plan.yearly_plan_according_bed_last(care.care_detail.no_of_beds),
      plan_id: Plan.yearly_plan_according_bed_last(care.care_detail.no_of_beds).id
    }
  end

   def retrieve_care_detail_last(care)
    { care_id: care.id,
      status: care.status,
      taxes: TAXES.dig(care.state.upcase.to_sym).to_f,
      name: care.name,
      bed: care.care_detail.no_of_beds,
      applicable_plan: Plan.monthly_plan_according_bed_last(care.care_detail.no_of_beds),
      plan_id: Plan.monthly_plan_according_bed_last(care.care_detail.no_of_beds).id
    }
  end

  def authorize!
    true
  end
end
