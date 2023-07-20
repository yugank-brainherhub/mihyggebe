require "rails_helper"

RSpec.describe LicencesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/licences").to route_to("licences#index")
    end

    it "routes to #new" do
      expect(:get => "/licences/new").to route_to("licences#new")
    end

    it "routes to #show" do
      expect(:get => "/licences/1").to route_to("licences#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/licences/1/edit").to route_to("licences#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/licences").to route_to("licences#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/licences/1").to route_to("licences#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/licences/1").to route_to("licences#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/licences/1").to route_to("licences#destroy", :id => "1")
    end
  end
end
