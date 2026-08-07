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

  describe "POST /api/v1/admin/auth/register" do
    context "with valid parameters" do
      it "registers a new user and returns a token and user details" do
        expect {
          post "/api/v1/admin/auth/register", params: { email: 'newadmin@example.com', password: 'password123', full_name: 'New Admin' }
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["token"]).to be_a(String)
        expect(json_response["user"]["email"]).to eq('newadmin@example.com')
        expect(json_response["user"]["full_name"]).to eq('New Admin')
        expect(json_response["user"]["id"]).to be_present
      end
    end

    context "with invalid parameters (missing email)" do
      it "returns a validation failure error" do
        expect {
          post "/api/v1/admin/auth/register", params: { password: 'password123' }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]["code"]).to eq("validation_failed")
        expect(json_response["error"]["details"]).to include("Email can't be blank")
      end
    end

    context "with duplicate email" do
      it "returns validation failure error" do
        expect {
          post "/api/v1/admin/auth/register", params: { email: 'admin@example.com', password: 'password123' }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]["code"]).to eq("validation_failed")
        expect(json_response["error"]["details"]).to include("Email has already been taken")
      end
    end
  end
end
