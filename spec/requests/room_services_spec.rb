require 'rails_helper'

RSpec.describe "RoomServices", type: :request do
  describe "GET /room_services" do
    it "works! (now write some real specs)" do
      get room_services_path
      expect(response).to have_http_status(200)
    end
  end
end
