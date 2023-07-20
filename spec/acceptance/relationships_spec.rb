# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Relationships' do
  include_context 'api request'

  header 'Authorization', :authorization

  get '/api/relationships' do
    before do
      FactoryBot.create(:relationship, :as_brother)
      FactoryBot.create(:relationship, :as_father)
      FactoryBot.create(:relationship, :as_mother)
    end
    example 'list relationships' do
      do_request
      status.should == 200
    end
  end
  
  post '/api/relationships' do
    example 'Add relationship' do
      do_request(relationship: {name: 'Step Mother'})
      status.should == 200
    end
  end

end
