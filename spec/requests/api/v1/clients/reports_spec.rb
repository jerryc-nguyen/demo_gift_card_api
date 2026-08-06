require 'rails_helper'

RSpec.describe "Api::V1::Clients::Reports", type: :request do
  let(:client) { create(:client) }
  let(:headers) { { "X-Api-Key" => client.api_key } }

  describe "GET /api/v1/clients/reports/spending" do
    it "returns a CSV string for spending report" do
      get "/api/v1/clients/reports/spending", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["csv"]).to be_a(String)
    end
  end

  describe "GET /api/v1/clients/reports/cancel" do
    it "returns a CSV string for cancel report" do
      get "/api/v1/clients/reports/cancel", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["csv"]).to be_a(String)
    end
  end
end
