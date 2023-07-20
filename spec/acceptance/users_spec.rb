# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Users' do
  include_context 'api request'

  post '/api/users' do
    example 'provider/customer signup -success' do
      do_request(user: { first_name: 'testuser', 
                         last_name: 'test',
                         email: 'xyz@gmail.com',
                         password: "xyz123",
                         password_confirmation: "xyz123",
                         messanger_id: "xyz", 
                         mobile: '134-930-8398', 
                         above18: true,
                         role_id: provider_role.id
                        })
      status.should == 200
    end
  end

  post '/api/users' do
    example 'provider/customer signup- failure if mandatory fields missing ' do
      do_request(user: { first_name: nil, 
                         last_name: 'test',
                         email: 'xyz@gmail.com',
                         password: "xyz123",
                         password_confirmation: "xyz123",
                         messanger_id: "xyz", 
                         mobile: '134-930-8398', 
                         above18: true,
                         role_id: customer_role.id
                        })
      status.should == 422
    end
  end

  post '/api/users' do
    example 'social worker signup- success' do
      do_request(user: { first_name: "user", 
                         last_name: 'test', 
                         messanger_id: "xyz", 
                         mobile: '134-930-8398', 
                         above18: true,
                         role_id: social_worker_role.id,
                         organization: "tetorganization",
                         profession: "Doctor",
                         address: "xyx road, bangalore",
                         email: 'xyz@gmail.com',
                         password: "xyz123",
                         password_confirmation: "xyz123"
                        })

      status.should == 200
    end
  end

  put '/api/users/:id/change_password' do
    header 'Authorization', :provider_authorization
    example 'customer/provider change_password-success' do
      do_request(id: provider_user.id,
                         user: {
                         current_password: 'Test@1234',
                         password: "xyz1234",
                         password_confirmation: "xyz1234"
                        })
      status.should == 200
    end
  end

  put '/api/users/:id/change_password' do
    header 'Authorization', :provider_authorization
    example 'customer/provider change_password- password and password_confirmation should match' do
      do_request(id: provider_user.id,
                         user: { 
                         current_password: 'Test@1234',
                         password: "xyz123",
                         password_confirmation: "xyz1234"
                        })
      status.should == 422
    end
  end

  get '/api/users/:id/confirm_email' do
    example 'customer/provider confirm_email-success' do
      do_request(id: provider_user.confirm_token)
      status.should == 302
    end
  end

  get '/api/users/:id/cares' do
    header 'Authorization', :provider_authorization
    example 'Provider: Fetch senior living cares' do
      do_request(id: provider_user.id, category: 'senior_living')
      status.should == 200
    end
  end

  get '/api/users/:id/cares' do
    header 'Authorization', :provider_authorization
    example 'Provider: Fetch homeshare cares' do
      do_request(id: provider_user.id, category: 'home_share')
      status.should == 200
    end
  end

  post '/api/users/login' do
    example 'customer/provider login' do
      do_request(email: provider_user.email, password: 'Test@1234')
      status.should == 200
    end
  end

  get '/api/users/:id/wishlists' do
    header 'Authorization', :provider_authorization
    example 'customer: Fetch wishlists' do
      do_request(id: provider_user.id)
      status.should == 200
    end
  end

  post '/api/users/:id/add_to_wishlist' do
    header 'Authorization', :provider_authorization
    example 'customer: add to wishlists' do
      do_request(id: provider_user.id, care_id: senior_living.id)
      status.should == 422
    end
  end

  delete '/api/users/:id/remove_wishlist' do
    header 'Authorization', :provider_authorization
    before do
      FactoryBot.create(:wishlist, care: senior_living, user: provider)
    end
    example 'customer: remove from wishlists' do
      do_request(id: provider_user.id, wishlist_id: Wishlist.first.id)
      status.should == 204
    end
  end


  get '/api/users/:id/bookings' do
    header 'Authorization', :provider_authorization
    example 'Provider: Fetch bookings' do
      do_request(id: provider_user.id)
      status.should == 200
    end
  end

  get '/api/users/:id/bookings' do
    header 'Authorization', :provider_authorization
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.second, service: Service.first)
      FactoryBot.create(:relationship, :as_brother)
      FactoryBot.create(:booking, care: homeshare, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      } )
      FactoryBot.create(:booking, care: senior_living, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      })
    end
    example 'Provider:Filter senior living bookings' do
      do_request(id: provider_user.id, category: 'senior_living')
      status.should == 200
    end
  end

  get '/api/users/:id/bookings' do
    header 'Authorization', :provider_authorization
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: homeshare)
      FactoryBot.create(:bed, room: Room.second, service: Service.first)
      FactoryBot.create(:relationship, :as_brother)
      FactoryBot.create(:booking, care: homeshare, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      } )
      FactoryBot.create(:booking, care: senior_living, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      })
    end
    example 'Provider: Filter home share bookings' do
      do_request(id: provider_user.id, category: 'home_share')
      status.should == 200
    end
  end

  get '/api/users/:id/bookings' do
    header 'Authorization', :provider_authorization
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: homeshare)
      FactoryBot.create(:bed, room: Room.second, service: Service.first)
      FactoryBot.create(:relationship, :as_brother)
      FactoryBot.create(:booking, care: homeshare, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      } )
      FactoryBot.create(:booking, care: senior_living, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      })
    end
    example 'Provider: Filter bookings by booking id' do
      do_request(id: provider_user.id, booking_id: Booking.first.bookingID)
      status.should == 200
    end
  end

  get '/api/users/:id/bookings' do
    header 'Authorization', :customer_authorization
    example 'Customer: Fetch bookings' do
      do_request(id: customer_user.id)
      status.should == 200
    end
  end


  get '/api/users/:id/bookings' do
    header 'Authorization', :customer_authorization
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: homeshare)
      FactoryBot.create(:bed, room: Room.second, service: Service.first)
      FactoryBot.create(:relationship, :as_brother)
      FactoryBot.create(:booking, care: homeshare, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      } )
      FactoryBot.create(:booking, care: senior_living, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      })
    end
    example 'Customer:Filter past bookings' do
      do_request(id: customer_user.id, filter: 'past')
      status.should == 200
    end
  end

  get '/api/users/:id/bookings' do
    header 'Authorization', :customer_authorization
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: homeshare)
      FactoryBot.create(:bed, room: Room.second, service: Service.first)
      FactoryBot.create(:relationship, :as_brother)
      FactoryBot.create(:booking, care: homeshare, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      } )
      FactoryBot.create(:booking, care: senior_living, user: provider_user, relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      })
    end
    example 'Customer: Filter active bookings' do
      do_request(id: customer_user.id, filter: 'active')
      status.should == 200
    end
  end

  get '/api/users/:id/bookings' do
    header 'Authorization', :customer_authorization
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: homeshare)
      FactoryBot.create(:bed, room: Room.second, service: Service.first)
      FactoryBot.create(:relationship, :as_brother)
      FactoryBot.create(:booking, care: homeshare, user: provider_user, status: 'cancelled', relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      })
      FactoryBot.create(:booking, care: senior_living, user: provider_user,  status: 'terminated', relationship: Relationship.first, bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      })
    end
    example 'Customer: Filter cancelled bookings' do
      do_request(id: customer_user.id, filter: 'cancelled')
      status.should == 200
    end
  end
end
