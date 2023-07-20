require 'rails_helper'

RSpec.describe "ProviderSupports", type: :request do
  describe "GET /provider_supports" do
    it "works! (now write some real specs)" do
      get provider_supports_path
      expect(response).to have_http_status(200)
    end
  end
end
