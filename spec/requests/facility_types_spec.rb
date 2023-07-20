require 'rails_helper'

RSpec.describe "FacilityTypes", type: :request do
  describe "GET /facility_types" do
    it "works! (now write some real specs)" do
      get facility_types_path
      expect(response).to have_http_status(200)
    end
  end
end
