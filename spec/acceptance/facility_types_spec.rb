# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Facility types' do
  include_context 'api request'

  header 'Authorization', :provider_authorization

  get '/api/facility_types' do
    before do
      FactoryBot.create(:facility_type, :general_wellness)
      FactoryBot.create(:facility_type, :pets)
      FactoryBot.create(:facility_type, :meals)
      FactoryBot.create(:facility_type, :parking)
    end
    example 'list facility types' do
      do_request
      status.should == 200
    end
  end
end
