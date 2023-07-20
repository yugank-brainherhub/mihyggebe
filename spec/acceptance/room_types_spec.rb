# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Room types' do
  include_context 'api request'

  header 'Authorization', :authorization

  get '/api/room_types' do
    before do
      FactoryBot.create(:room_type, :dining)
      FactoryBot.create(:room_type, :living)
      FactoryBot.create(:room_type, :kitchen)
      FactoryBot.create(:room_type, :parking)
    end
    example 'list room types' do
      do_request
      status.should == 200
    end
  end
end
