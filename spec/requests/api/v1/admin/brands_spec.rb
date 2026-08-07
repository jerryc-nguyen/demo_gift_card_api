require 'rails_helper'

RSpec.describe "Api::V1::Admin::Brands", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/admin/brands" do
    context "with valid parameters" do
      it "creates a new brand" do
        expect {
          post "/api/v1/admin/brands", params: { name: "New Brand", website: "https://brand.com" }, headers: headers
        }.to change(Brand, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["name"]).to eq("New Brand")
      end
    end

    context "with invalid parameters" do
      it "returns a validation failed error" do
        post "/api/v1/admin/brands", params: { name: "" }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]["code"]).to eq("validation_failed")
      end
    end
  end

  describe "PUT /api/v1/admin/brands/:id/update_status" do
    let!(:brand) { create(:brand, status: :inactive) }

    it "updates the brand status" do
      put "/api/v1/admin/brands/#{brand.id}/update_status", params: { status: "active" }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(brand.reload.status).to eq("active")
    end
  end
end
