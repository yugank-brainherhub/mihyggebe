# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Bed services' do
  include_context 'api request'

  header 'Authorization', :provider_authorization

  get '/api/cares/:id/services' do
    before do
      FactoryBot.create(:care, user: provider)
    end
    example 'list selected care provided services : care' do
      do_request(id: Care.first.id)
      status.should == 200
    end
  end
end
