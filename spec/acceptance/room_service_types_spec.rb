# frozen_string_literal: true
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Room amenities' do
  include_context 'api request'

  header 'Authorization', :provider_authorization

  get '/api/room_service_types' do
    before do
      FactoryBot.create(:room_service_type, :utility)
    end
    example 'list room_service_types' do
      do_request
      status.should == 200
    end
  end
end
