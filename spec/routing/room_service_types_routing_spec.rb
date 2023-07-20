require "rails_helper"

RSpec.describe RoomServiceTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/room_service_types").to route_to("room_service_types#index")
    end

    it "routes to #new" do
      expect(:get => "/room_service_types/new").to route_to("room_service_types#new")
    end

    it "routes to #show" do
      expect(:get => "/room_service_types/1").to route_to("room_service_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/room_service_types/1/edit").to route_to("room_service_types#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/room_service_types").to route_to("room_service_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/room_service_types/1").to route_to("room_service_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/room_service_types/1").to route_to("room_service_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/room_service_types/1").to route_to("room_service_types#destroy", :id => "1")
    end
  end
end
