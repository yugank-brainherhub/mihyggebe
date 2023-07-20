require 'rails_helper'

RSpec.describe "StaffRoles", type: :request do
  describe "GET /staff_roles" do
    it "works! (now write some real specs)" do
      get staff_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
