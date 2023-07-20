# frozen_string_literal: true

require 'net/http'
require 'uri'

class API::V1::Checker::CreateCandidateAction < Abstract::BaseAction
  attr_accessor :candidate, :invitation

  CHECKER_URL = 'https://api.checkr.com/v1/candidates'
  CHECKER_INVITE_URL = 'https://api.checkr.com/v1/invitations'
  CHECKER_PACKAGE = 'tasker_standard'
  def perform
    create_candidate_params = current_user.slice(:email, :first_name, :last_name)
    create_response = request_checker(CHECKER_URL, create_candidate_params)
    @candidate = JSON.parse(create_response.body)
    invite_params = {
      candidate_id: candidate['id'],
      package: CHECKER_PACKAGE
    }
    invitation_response = request_checker(CHECKER_INVITE_URL, invite_params)
    @invitation = JSON.parse(invitation_response.body)
    @success = current_user.update(checkrId: candidate['id'])
  end

  def request_checker(uri_to_parse, params)
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

  def data
    { url: invitation['invitation_url'] }
  end

  def authorize!
    true
  end
end
