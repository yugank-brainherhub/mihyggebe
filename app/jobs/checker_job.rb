# frozen_string_literal: true
require 'net/http'
require 'uri'

class CheckerJob < ApplicationJob

  CHECKER_URL = 'https://api.checkr.com/v1/candidates'
  CHECKER_INVITE_URL = 'https://api.checkr.com/v1/invitations'
  CHECKER_PACKAGE = (Rails.env.production? ? 'pro_criminal' : 'tasker_standard')

  queue_as :default

  def self.perform(user_id)
    current_user = User.find(user_id)
    create_candidate_params = current_user.slice(:email, :first_name, :last_name)
    create_response = request_checker(CHECKER_URL, create_candidate_params)
    candidate = JSON.parse(create_response.body)
    invite_params = {
      candidate_id: candidate['id'],
      package: CHECKER_PACKAGE
    }
    invitation_response = request_checker(CHECKER_INVITE_URL, invite_params)
    invitation = JSON.parse(invitation_response.body)
    current_user.update(checkrId: candidate['id'])
    url = invitation['invitation_url']
    UserMailer.with(user: current_user).send_checkr_status('initiate', url).deliver_now
  end

  def self.request_checker(uri_to_parse, params)
    uri = URI.parse(uri_to_parse)
    request = Net::HTTP::Post.new(uri)
    request.basic_auth(DEFAULTS[:checker_key], '')
    request.set_form_data(
      params
    )

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end
