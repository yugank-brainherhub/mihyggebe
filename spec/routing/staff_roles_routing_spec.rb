require "rails_helper"

RSpec.describe StaffRolesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/staff_roles").to route_to("staff_roles#index")
    end

    it "routes to #new" do
      expect(:get => "/staff_roles/new").to route_to("staff_roles#new")
    end

    it "routes to #show" do
      expect(:get => "/staff_roles/1").to route_to("staff_roles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/staff_roles/1/edit").to route_to("staff_roles#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/staff_roles").to route_to("staff_roles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/staff_roles/1").to route_to("staff_roles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/staff_roles/1").to route_to("staff_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/staff_roles/1").to route_to("staff_roles#destroy", :id => "1")
    end
  end
end
