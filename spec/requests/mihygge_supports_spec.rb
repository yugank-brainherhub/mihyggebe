require 'rails_helper'

RSpec.describe "MihyggeSupports", type: :request do
  describe "GET /mihygge_supports" do
    it "works! (now write some real specs)" do
      get mihygge_supports_path
      expect(response).to have_http_status(200)
    end
  end
end
