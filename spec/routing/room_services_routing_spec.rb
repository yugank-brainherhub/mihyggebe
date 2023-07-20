require "rails_helper"

RSpec.describe RoomServicesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/room_services").to route_to("room_services#index")
    end

    it "routes to #new" do
      expect(:get => "/room_services/new").to route_to("room_services#new")
    end

    it "routes to #show" do
      expect(:get => "/room_services/1").to route_to("room_services#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/room_services/1/edit").to route_to("room_services#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/room_services").to route_to("room_services#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/room_services/1").to route_to("room_services#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/room_services/1").to route_to("room_services#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/room_services/1").to route_to("room_services#destroy", :id => "1")
    end
  end
end
