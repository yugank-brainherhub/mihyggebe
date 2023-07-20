# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Rooms' do
  include_context 'api request'
  header 'Authorization', :provider_authorization

  post '/api/rooms' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, user: provider)
    end
    example 'ADD ROOM Failure: if beds count is not as per room type ' do
      do_request(room: { name: 'room no 123', 
                         room_type: 'single',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food", 
                         available_from: Date.today.to_datetime,
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 1,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '1' => {
                              bed_number: 2,
                              bed_type: 'queen',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end


  post '/api/rooms' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
    end
    example 'ADD ROOM: provider care senior living add room details -success' do
      do_request(room: { name: 'room no 123', 
                         room_type: 'single',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food", 
                         available_from: Date.today.to_datetime,
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 1,
                              bed_type: 'king',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 200
    end
  end

  post '/api/rooms' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
    end
    example 'ADD ROOM Failure- if no of beds added are greater than total beds allowed' do
      do_request(room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food", 
                         available_from: Date.today.to_datetime,
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 1,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '1' => {
                              bed_number: '1A',
                              bed_type: 'king',
                              service_id: Service.first.id
                            },

                            '2' => {
                              bed_number: '1B',
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '3' => {
                              bed_number: '1C',
                              bed_type: 'king',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end

  post '/api/rooms' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
      FactoryBot.create(:room, care: Care.first)
      FactoryBot.create(:room, care: Care.first)
    end
    example 'ADD ROOM Failure- if no of rooms added are greater than total rooms allowed' do
      do_request(room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food", 
                         available_from: Date.today.to_datetime,
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end

  post '/api/rooms' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
    end
    example 'ADD ROOM Failure- if available_from is less than today date' do
      do_request(room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food", 
                         available_from: Date.yesterday.to_datetime,
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end


  post '/api/rooms' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
    end
    example 'ADD ROOM Failure- if available_to is less than today date and available_from' do
      do_request(room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food", 
                         available_from: Date.yesterday.to_datetime,
                         available_to: Date.yesterday.to_datetime,
                         care_id: Care.first.id,
                         selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end

  
  post '/api/rooms' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
    end
    example 'ADD ROOM Failure- if bed number has more than 10 characters' do
      do_request(room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food", 
                         available_from: Date.today.to_datetime,
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 123456789012,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '1' => {
                              bed_number: '1A',
                              bed_type: 'king',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end






  put '/api/rooms/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
      FactoryBot.create(:room, care: Care.first)
    end
    example 'UPDATE ROOM : provider update room details -success' do
      do_request(id: Room.first.id, room: { name: 'room no 123', 
                         room_type: 'single',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food",
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 1,
                              bed_type: 'king',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 200
    end
  end


  put '/api/rooms/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
      FactoryBot.create(:room, care: Care.first)
    end
    example 'UPDATE ROOM Failure: if beds count is not as per room type' do
      do_request(id: Room.first.id, room: { name: 'room no 123', 
                         room_type: 'single',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food",
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 1,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '1' => {
                              bed_number: 12,
                              bed_type: 'king',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end

  put '/api/rooms/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
      FactoryBot.create(:room, care: Care.first)
    end
    example 'UPDATE ROOM Failure: if no of beds added are greater than total beds allowed' do
      do_request(id: Room.first.id, room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food",
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 1,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '1' => {
                              bed_number: 12,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '2' => {
                              bed_number: 123,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '3' => {
                              bed_number: 1234,
                              bed_type: 'king',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end


  put '/api/rooms/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
      FactoryBot.create(:room, care: Care.first)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:room, care: Care.first)
    end
    example 'UPDATE ROOM Failure: if no of beds added in all rooms are greater than total beds allowed' do
      do_request(id: Room.last.id, room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food",
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Care.first.id,
                         beds_attributes: {
                           '0' => {
                              bed_number: 1,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '1' => {
                              bed_number: 12,
                              bed_type: 'king',
                              service_id: Service.first.id
                            }
                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end


  put '/api/rooms/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
      FactoryBot.create(:room, care: Care.first)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
    end
    example 'UPDATE ROOM SUCCESS: remove one bed and add one more bed, update room type.' do
      do_request(id: Room.first.id, room: { name: 'room no 123', 
                         room_type: 'for-three',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food",
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Room.first.care.id,
                         beds_attributes: {
                           '0' => {
                              id: Room.first.beds.first.id,
                              _destroy: 'true'
                            },
                            '1' => {
                              bed_number: 12,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '2' => {
                              bed_number: 123,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },

                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 200
    end
  end

    put '/api/rooms/:id' do
    before do
      FactoryBot.create(:service_type, :general_wellness)
      FactoryBot.create(:room_service_type, :utility)
      FactoryBot.create(:care, :as_sl, user: provider)
      FactoryBot.create(:room, care: Care.first)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
      FactoryBot.create(:bed, room: Room.first, service: Service.first)
    end
    example 'UPDATE ROOM Failure: remove one bed and add 3 more bed, update room type.' do
      do_request(id: Room.first.id, room: { name: 'room no 123', 
                         room_type: 'for-four',
                         bedroom_type: 'attached',
                         price: 40,
                         price_desc: "price includes food",
                         available_to: Date.tomorrow.to_datetime,
                         care_id: Room.first.care.id,
                         beds_attributes: {
                           '0' => {
                              id: Room.first.beds.first.id,
                              _destroy: 'true'
                            },
                            '1' => {
                              bed_number: 12,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '2' => {
                              bed_number: 123,
                              bed_type: 'king',
                              service_id: Service.first.id
                            },
                            '3' => {
                              bed_number: 123,
                              bed_type: 'king',
                              service_id: Service.first.id
                            }

                          },
                          selected_room_services_attributes: {
                            '0' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }, 
                            '1' => {
                              room_service_type_id: RoomServiceType.first.id,
                              room_service_id: RoomServiceType.first.room_services.first.id
                            }
                          }
                        })
      status.should == 422
    end
  end









  get '/api/rooms/:id' do
    before do
      FactoryBot.create(:care, user: provider)
      FactoryBot.create(:room, care: Care.first)
    end
    example 'view room details -success' do
      do_request(id: Room.first.id)
      status.should == 200
    end
  end


  

end
