# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'cares' do
  include_context 'api request'
  header 'Authorization', :provider_authorization

  post '/api/cares' do
    example 'provider care senior living creation -success' do
      do_request(care: { 
                         name: 'testcare',
                         address1: 'room no 123, xyz apartment', 
                         address2: '2nd cross road , pqr estate',
                         address3: 'Bangalore, 5678093',
                         state: "Karnataka",
                         county: "Bangalore", 
                         country: 'India',
                         zipcode: '456789', 
                         fax_number: '123485990',
                         category: 'senior_living',
                         status: 'pending',
                         licences_attributes: {
                           '0' => {
                              licence_type: 'regular',
                              file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg')
                            },
                            '1' => {
                              licence_type: 'hospice',
                              file: Rack::Test::UploadedFile.new('spec/factories/test.jpg', 'image/jpeg')
                            }
                          }
                        })
      status.should == 200
    end
  end

  post '/api/cares' do
    example 'provider care homeshare creation -success' do
      do_request(care: { 
                         name: 'testcare',
                         address1: 'room no 123, xyz apartment', 
                         address2: '2nd cross road , pqr estate',
                         address3: 'Bangalore, 5678093',
                         state: "Karnataka",
                         county: "Bangalore", 
                         country: 'India',
                         zipcode: '456789',
                         fax_number: '123485990',
                         category: 'home_share',
                         status: 'pending',
                         licences_attributes: {
                           '0' => {
                              licence_type: 'regular',
                              file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg')
                            },
                            '1' => {
                              licence_type: 'hospice',
                              file: Rack::Test::UploadedFile.new('spec/factories/test.jpg', 'image/jpeg')
                            }
                          }
                        })

      status.should == 200
    end
  end

  put '/api/cares/:id' do
    before do
      FactoryBot.create(:staff_role, :as_owner)
      FactoryBot.create(:staff_role, :as_ad)
      FactoryBot.create(:staff_role, :as_ed)
      FactoryBot.create(:staff_role, :as_administrator)
    end
    example 'Add staff details for care update -success' do
      do_request(id: senior_living.id , type: 'staff_details', care: { board_members: 'xyz, pqr, uvw', 
                         staff_details_attributes: {
                           '0' => {
                              name: 'naveen',
                              staff_role_id: StaffRole.first.id
                            },
                            '1' => {
                              name: 'rajesh',
                              staff_role_id: StaffRole.second.id
                            }
                          }
                        })

      status.should == 200
    end
  end


  get '/api/cares/:id' do
    example 'view staff details of care -success' do
      do_request(id: senior_living.id , type: 'staff_details')

      status.should == 200
    end
  end

  put '/api/cares/:id' do
    before do
      FactoryBot.create(:room_type, :dining)
      FactoryBot.create(:room_type, :living)
      FactoryBot.create(:room_type, :kitchen)
      FactoryBot.create(:room_type, :parking)
    end
    example 'Add care details for care update -success' do
      do_request(id: senior_living.id , type: 'care_details', care: {
                         selected_rooms_attributes: {
                           '0' => {
                              room_type_id: RoomType.first.id
                            },
                            '1' => {
                              name: 'rajesh',
                              room_type_id: RoomType.second.id
                            }
                          },
                          care_detail_attributes: {
                            description: 'senior iving is best for ',
                            area_description: 'This care located far away from city..',
                            no_of_rooms: 6,
                            no_of_beds: 3,
                            no_of_restrooms: 3,
                            no_of_bathrooms: 4
                          }
                        })

      status.should == 200
    end
  end


  get '/api/cares/:id' do
    example 'view care details of care -success' do
      do_request(id: senior_living.id , type: 'care_details')

      status.should == 200
    end
  end


  put '/api/cares/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:service_type, :fitness)
      FactoryBot.create(:service_type, :recreation)
    end
    example 'Add care&service details for care update -success' do
      do_request(id: senior_living.id , type: 'service_details', care: {
                         selected_services_attributes: {
                           '0' => {
                              service_type_id: ServiceType.first.id,
                              service_id: ServiceType.first.services.first.id
                            },
                            '1' => {
                              service_type_id: ServiceType.second.id,
                              service_id: ServiceType.second.services.first.id
                            }
                          }
                        })

      status.should == 200
    end
  end

  get '/api/cares/:id' do
    example 'view care&service details for care -success' do
      do_request(id: senior_living.id , type: 'service_details')

      status.should == 200
    end
  end

  put '/api/cares/:id' do
    before do
      FactoryBot.create(:facility_type, :general_wellness)
      FactoryBot.create(:facility_type, :parking)
      FactoryBot.create(:facility_type, :pets)
    end
    example 'Add facility details for care update -success' do
      do_request(id: senior_living.id , type: 'facility_details', care: {
                         selected_facilities_attributes: {
                           '0' => {
                              facility_type_id: FacilityType.first.id,
                              facility_id: FacilityType.first.facilities.first.id
                            },
                            '1' => {
                              facility_type_id: FacilityType.second.id,
                              facility_id: FacilityType.second.facilities.first.id
                            }
                          }
                        })

      status.should == 200
    end
  end

  get '/api/cares/:id' do
    example 'view facility details of care -success' do
      do_request(id: senior_living.id , type: 'facility_details')

      status.should == 200
    end
  end

  
  put '/api/cares/:id' do
    example 'Update care profile&licence details- success' do
      do_request(id: senior_living.id, care: { 
                         name: 'testcare',
                         address1: 'room no 123, xyz apartment', 
                         address2: '2nd cross road , pqr estate',
                         address3: 'Bangalore, 5678093',
                         state: "Karnataka",
                         county: "Bangalore", 
                         country: 'India',
                         zipcode: '456789',
                         fax_number: '123485990',
                         category: 'home_share',
                         licences_attributes: {
                           '0' => {
                              id: senior_living.licences.first.id,
                              licence_type: 'regular'
                            },
                            '1' => {
                              id: senior_living.licences.second.id,
                              _destroy: true
                            }
                          }
                        })

      status.should == 200
    end
  end


  put '/api/cares/:id' do
    before do
      FactoryBot.create(:staff_role, :as_owner)
      FactoryBot.create(:staff_role, :as_ad)
      FactoryBot.create(:staff_role, :as_ed)
      FactoryBot.create(:staff_role, :as_administrator)
      senior_living.staff_details.create(name: 'testuser', staff_role_id: StaffRole.first.id)
      senior_living.staff_details.create(name: 'testuser2', staff_role_id: StaffRole.last.id)
    end
    example 'Update care staff details -success' do
      do_request(id: senior_living.id , type: 'staff_details', care: { board_members: 'xyz, pqr', 
                         staff_details_attributes: {
                           '0' => {
                              staff_role_id: StaffRole.first.id,
                              name: 'naveen'
                            }
                          }
                        })

      status.should == 200
    end
  end


  put '/api/cares/:id' do
    before do
      FactoryBot.create(:room_type, :dining)
      FactoryBot.create(:room_type, :living)
      FactoryBot.create(:room_type, :kitchen)
      FactoryBot.create(:room_type, :parking)
      senior_living.selected_rooms.create(room_type_id: RoomType.first.id)
      FactoryBot.create(:care_detail, care: senior_living)
    end
    example 'Update care details -success' do
      do_request(id: senior_living.id , type: 'care_details', care: {
                         selected_rooms_attributes: {
                            '1' => {
                              name: 'rajesh',
                              room_type_id: RoomType.second.id
                            }
                          },
                          care_detail_attributes: {
                            id: senior_living.care_detail.id,
                            description: 'senior iving is best for ',
                            area_description: 'This care located far away from city..',
                            no_of_rooms: 6,
                            no_of_beds: 3,
                            no_of_restrooms: 3,
                            no_of_bathrooms: 4
                          }
                        })
      status.should == 200
    end
  end


  put '/api/cares/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:service_type, :fitness)
      FactoryBot.create(:service_type, :recreation)
      senior_living.selected_services.create(service_type_id: ServiceType.first.id)
    end
    example 'Update  care&service details-success' do
      do_request(id: senior_living.id , type: 'service_details', care: {
                         selected_services_attributes: {
                           '0' => {
                              id: senior_living.selected_services.first.id,
                              _destroy: true
                            },
                            '1' => {
                              service_type_id: ServiceType.second.id,
                              service_id: ServiceType.second.services.first.id
                            }
                          }
                        })

      status.should == 200
    end
  end


  put '/api/cares/:id' do
    before do
      FactoryBot.create(:facility_type, :general_wellness)
      FactoryBot.create(:facility_type, :parking)
      FactoryBot.create(:facility_type, :pets)
      senior_living.selected_facilities.create(facility_type_id: FacilityType.first.id)
    end
    example 'update care facility details -success' do
      do_request(id: senior_living.id , type: 'facility_details', care: {
                         selected_facilities_attributes: {
                           '0' => {
                              id: senior_living.selected_facilities.first.id,
                              _destroy: true
                            },
                            '1' => {
                              facility_type_id: FacilityType.second.id,
                              facility_id: FacilityType.second.facilities.first.id
                            }
                          }
                        })

      status.should == 200
    end
  end

  get '/api/cares/search' do
    with_options with_example: true do
      parameter :location, 'county zipcode state country of care', required: true
      parameter :care_types, 'care types selected in dropdown', required: true
      parameter :checkin, 'checkin date', required: true, default: Time.current
      parameter :checkout,  'checkout date', required: true, default: Time.current+15.days
      parameter :category, 'senior_living or homeshare', required: true
    end
    example 'Customer: care search main filter -success' do
      do_request(location: '456789' , care_types: ['Direct Access to street or ground floor', 'Non-Smoking','Lift'], 
                  checkin: Time.current,
                  checkout: Time.current+ 15.days,
                  category: 'senior_living'
                )
      status.should == 200
    end
  end

  get '/api/cares/search' do
    with_options with_example: true do
      parameter :location, 'county zipcode state country of care', required: true
      parameter :care_types, 'care types selected in dropdown', required: true
      parameter :checkin, 'checkin date', required: true, default: Time.current
      parameter :checkout,  'checkout date', required: true, default: Time.current+15.days
      parameter :category, 'senior_living or homeshare', required: true
    end
    example 'Customer: care search, mandatory params missing -failure' do
      do_request(location: '456789' , care_types: ['Direct Access to street or ground floor', 'Non-Smoking','Lift'], 
                  checkin: Date.today,
                  checkout: Time.current+ 15.days
                )

      status.should == 422
    end
  end

  get '/api/cares/search' do
    with_options with_example: true do
      parameter :location, 'county zipcode state country of care', required: true, type: [:string]
      parameter :care_types, 'care types selected in dropdown', required: true, type: [:string]
      parameter :checkin, 'checkin date', required: true, default: Time.current, type: [:string]
      parameter :checkout,  'checkout date', required: true, default: Time.current+15.days, type: [:string]
      parameter :category, 'senior_living or homeshare', required: true, type: [:string]
      parameter :room_type, 'values should be any of osingle double for-three for-four', optional: true
      parameter :bed_type, 'twin king queen hospital', optional: true
      parameter :licence_type, 'regular hospice others', optional: true
      parameter :amenities, 'care amenities dropdown values', optional: true
      parameter :services, 'care services dropdown values', optional: true
      parameter :max, 'maximum limit for price, integer', optional: true
      parameter :min, 'minimum limit for price,integer', optional: true
      parameter :distance, 'distance, number', optional: true
    end
    example 'Customer: care search including subfilters -success' do
      do_request(location: '456789' , care_types: ['Direct Access to street or ground floor', 'Non-Smoking','Lift'], 
                  checkin: Time.current,
                  checkout: Time.current+ 15.days,
                  category: 'senior_living',
                  room_types: ['single', 'double'],
                  bed_type: ['twin', 'hospital'],
                  licence_type: ['regular', 'hospice'],
                  amenities: ['24 Hour Security','24 Hour supervision'],
                  services: ['Fitness', 'Wellness', 'Restaurant'],
                  max: 50,
                  min: 10,
                  distance: 40
                )
      status.should == 200
    end
  end

  get '/api/cares/search' do
    with_options with_example: true do
      parameter :page, 'should be home_page', required: true
      parameter :type, 'type from autosearch api (country, county, state, zipcode)', required: true
      parameter :query, 'value from auto search', required: true
    end
    example 'Customer: search after autosearch result' do
      do_request(page: 'home_page',
                  type: 'country',
                  query: 'florida'
                )
      status.should == 200
    end
  end
end
