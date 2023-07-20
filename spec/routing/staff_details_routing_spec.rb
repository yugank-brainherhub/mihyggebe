require "rails_helper"

RSpec.describe StaffDetailsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/staff_details").to route_to("staff_details#index")
    end

    it "routes to #new" do
      expect(:get => "/staff_details/new").to route_to("staff_details#new")
    end

    it "routes to #show" do
      expect(:get => "/staff_details/1").to route_to("staff_details#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/staff_details/1/edit").to route_to("staff_details#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/staff_details").to route_to("staff_details#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/staff_details/1").to route_to("staff_details#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/staff_details/1").to route_to("staff_details#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/staff_details/1").to route_to("staff_details#destroy", :id => "1")
    end
  end
end
