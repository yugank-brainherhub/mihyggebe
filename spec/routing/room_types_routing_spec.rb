require "rails_helper"

RSpec.describe RoomTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/room_types").to route_to("room_types#index")
    end

    it "routes to #new" do
      expect(:get => "/room_types/new").to route_to("room_types#new")
    end

    it "routes to #show" do
      expect(:get => "/room_types/1").to route_to("room_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/room_types/1/edit").to route_to("room_types#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/room_types").to route_to("room_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/room_types/1").to route_to("room_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/room_types/1").to route_to("room_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/room_types/1").to route_to("room_types#destroy", :id => "1")
    end
  end
end
