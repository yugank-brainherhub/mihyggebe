# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Passwords' do
  include_context 'api request'

  post '/api/passwords' do
    example 'provider/customer forgot password' do
      do_request(email: provider_user.email)
      status.should == 200
    end
  end

  put '/api/passwords/:id' do
    example 'provider/customer change password ' do
      provider_user.generate_password_token!
      do_request(id: provider_user.reset_password_token, token: provider_user.reset_password_token,
                        user: { password: 'test@123', 
                         password_confirmation: "test@123"
                        })
      status.should == 200
    end
  end

  put '/api/passwords/:id' do
    example 'provider/customer change password failure- password mismatch ' do
      provider_user.generate_password_token!
      do_request(reset_password_token: provider_user.reset_password_token,
                        user: { password: 'test@1234', 
                         password_confirmation: "test@123"
                        })
      status.should == 422
    end
  end

end
