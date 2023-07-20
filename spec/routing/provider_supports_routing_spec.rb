require "rails_helper"

RSpec.describe ProviderSupportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/provider_supports").to route_to("provider_supports#index")
    end

    it "routes to #new" do
      expect(:get => "/provider_supports/new").to route_to("provider_supports#new")
    end

    it "routes to #show" do
      expect(:get => "/provider_supports/1").to route_to("provider_supports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/provider_supports/1/edit").to route_to("provider_supports#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/provider_supports").to route_to("provider_supports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/provider_supports/1").to route_to("provider_supports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/provider_supports/1").to route_to("provider_supports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/provider_supports/1").to route_to("provider_supports#destroy", :id => "1")
    end
  end
end
