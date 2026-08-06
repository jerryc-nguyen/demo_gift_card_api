require 'rails_helper'

RSpec.describe "Api::V1::Admin::Auth", type: :request do
  let!(:user) { create(:user, email: 'admin@example.com', password: 'password123') }

  describe "POST /api/v1/admin/auth/login" do
    context "with valid credentials" do
      it "returns a JWT token" do
        post "/api/v1/admin/auth/login", params: { email: 'admin@example.com', password: 'password123' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["token"]).to be_a(String)
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized error" do
        post "/api/v1/admin/auth/login", params: { email: 'admin@example.com', password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["error"]["code"]).to eq("unauthorized")
      end
    end
  end
end
