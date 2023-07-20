# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'beds' do
  include_context 'api request'

  header 'Authorization', :authorization

  
  post '/api/beds/hold' do
    example 'hold beds for 10 min' do
      do_request(bed_ids: [1,2,3])
      status.should == 200
    end
  end

end
