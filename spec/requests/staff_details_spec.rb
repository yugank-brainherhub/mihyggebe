require 'rails_helper'

RSpec.describe "StaffDetails", type: :request do
  describe "GET /staff_details" do
    it "works! (now write some real specs)" do
      get staff_details_path
      expect(response).to have_http_status(200)
    end
  end
end
