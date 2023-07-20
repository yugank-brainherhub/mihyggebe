# frozen_string_literal: true

class CheckrWebhookJob < ApplicationJob
  attr_accessor :parsed_data
  queue_as :default

  def perform(params)
    return if params.fetch(:checkr_signature) != params.fetch(:signature_to_match)

    @parsed_data = params.fetch(:data).fetch(:object).slice(:candidate_id, :status)
    record = User.find_by(checkrId: candidate_id)

    case params.fetch(:type)
    when 'report.created', 'report.completed'
      @status = case status
                when 'pending'
                  'checkr_pending'
                when 'clear'
                  'checkr_approved'
                else
                  'checkr_rejected'
                end
      UserMailer.with(user: record).send_checkr_status(@status).deliver_now if @status == 'checkr_pending'
      record.update(checkr_status: @status)
    when 'invitation.completed', 'invitation.expired', 'invitation.deleted'
      record.update(invitation_status: status)
    end
  end

  def status
    @parsed_data[:status]
  end

  def candidate_id
    @parsed_data[:candidate_id]
  end
end
