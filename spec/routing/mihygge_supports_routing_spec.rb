require "rails_helper"

RSpec.describe MihyggeSupportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/mihygge_supports").to route_to("mihygge_supports#index")
    end

    it "routes to #new" do
      expect(:get => "/mihygge_supports/new").to route_to("mihygge_supports#new")
    end

    it "routes to #show" do
      expect(:get => "/mihygge_supports/1").to route_to("mihygge_supports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mihygge_supports/1/edit").to route_to("mihygge_supports#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/mihygge_supports").to route_to("mihygge_supports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mihygge_supports/1").to route_to("mihygge_supports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mihygge_supports/1").to route_to("mihygge_supports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mihygge_supports/1").to route_to("mihygge_supports#destroy", :id => "1")
    end
  end
end
