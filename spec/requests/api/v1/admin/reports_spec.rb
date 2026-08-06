require 'rails_helper'

RSpec.describe "Api::V1::Admin::Reports", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{JwtService.encode(user_id: user.id)}" } }

  describe "GET /api/v1/admin/reports/brands" do
    it "returns a CSV string under brand reports" do
      get "/api/v1/admin/reports/brands", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["csv"]).to be_a(String)
    end
  end

  describe "GET /api/v1/admin/reports/clients" do
    it "returns a CSV string under client reports" do
      get "/api/v1/admin/reports/clients", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["csv"]).to be_a(String)
    end
  end
end
