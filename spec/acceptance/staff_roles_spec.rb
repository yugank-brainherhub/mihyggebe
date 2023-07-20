# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'staff_roles' do
  include_context 'api request'

  header 'Authorization', :authorization

  get '/api/staff_roles' do
    before do
      FactoryBot.create(:staff_role, :as_owner)
      FactoryBot.create(:staff_role, :as_ad)
      FactoryBot.create(:staff_role, :as_ed)
      FactoryBot.create(:staff_role, :as_administrator)
    end
    example 'list staff roles' do
      do_request
      status.should == 200
    end
  end
end
