require 'rails_helper'

RSpec.describe "RoomServiceTypes", type: :request do
  describe "GET /room_service_types" do
    it "works! (now write some real specs)" do
      get room_service_types_path
      expect(response).to have_http_status(200)
    end
  end
end
