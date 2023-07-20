# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Bookings' do
  include_context 'api request'

  post '/api/bookings' do
    header 'Authorization', :provider_authorization
    before do 
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room, care: senior_living)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: homeshare)
      FactoryBot.create(:bed, room: Room.second, service: Service.first)
      FactoryBot.create(:relationship, :as_brother)
    end

    with_options with_example: true do
      parameter :first_name, 'first name of customer', required: true, type: [:string]
      parameter :last_name, 'last name  of customer', required: true, type: [:string]
      parameter :email, 'email of customer', required: true, type: [:string]
      parameter :mobile,  'mobile number of customer', required: true, type: [:string]
      parameter :checkin, 'checkin date of booking, can not be less than today', required: true, type: [:string]
      parameter :checkout, 'checkout date of booking, can not be less than today and checkin', required: true
      parameter :arrival_time, 'arrival time of booking', required: true
      parameter :care_id, 'care id of care for which booking is created', required: true
      parameter :user_id, 'id of user who is creating booking', required: true
      parameter :relationship_id, 'get relationship ids from relationships api', required: true
      parameter :no_of_guests, 'number of guests', optional: true
      parameter :bed_bookings_attributes, 'bed ids for which booking is created', required: true
    end
    example 'Add booking' do
      do_request(booking: { first_name: 'John', 
                      last_name: 'james', 
                      email: "johnjames@gmail.com",
                      mobile: '12434934580',
                      checkin: Date.tomorrow,
                      checkout: Date.tomorrow + 2.days,
                      arrival_time: '2 pm', 
                      care_id: senior_living.id,
                      user_id: provider.id,
                      relationship_id: Relationship.first.id,
                      no_of_guests: 2,
                      price_includes: Room.first.price_desc,
                      bed_bookings_attributes: {
                        '0' => { bed_id: Bed.first.id },
                        '1' => { bed_id: Bed.last.id }
                      } 
                    }
                  )
      status.should == 200
    end
  end

  put '/api/bookings/:id' do
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
    example 'update booking status' do
      do_request(id: Booking.first.id, booking: { status: 'accepted' 
                    }
                  )
      status.should == 200
    end
  end

  put '/api/bookings/:id' do
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
    example 'Failure: if wrong status value sent' do
      do_request(id: Booking.first.id, booking: { status: 'accept' })
      status.should == 200
    end
  end

  put '/api/bookings/:id' do
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
    with_options with_example: true do
      parameter :doc_received, 'true/false', required: true, type: [:string]
    end
    example 'update booking doc received status' do
      do_request(id: Booking.first.id, booking: { doc_received: true
                    }
                  )
      status.should == 200
    end
  end

end
