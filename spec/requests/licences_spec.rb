require 'rails_helper'

RSpec.describe "Licences", type: :request do
  describe "GET /licences" do
    it "works! (now write some real specs)" do
      get licences_path
      expect(response).to have_http_status(200)
    end
  end
end
