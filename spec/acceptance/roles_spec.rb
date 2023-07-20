# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Roles' do
  include_context 'api request'

  header 'Authorization', :authorization

  get '/api/roles' do
    before do
      FactoryBot.create(:role, :as_customer)
      FactoryBot.create(:role, :as_social_worker)
      FactoryBot.create(:role, :as_provider)
      FactoryBot.create(:role, :as_admin)
    end
    example 'list roles' do
      do_request
      status.should == 200
    end
  end
end
