require 'rails_helper'

RSpec.describe "Api::V1::Admin::Products", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{JwtService.encode(user_id: user.id)}" } }
  let(:brand) { create(:brand) }

  describe "POST /api/v1/admin/products" do
    context "with valid parameters" do
      it "creates a new product under the brand" do
        expect {
          post "/api/v1/admin/products", params: { brand_id: brand.id, name: "New Product", price: 15.0 }, headers: headers
        }.to change(Product, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["name"]).to eq("New Product")
      end
    end

    context "with invalid parameters" do
      it "returns a validation failed error" do
        post "/api/v1/admin/products", params: { brand_id: brand.id, name: "" }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]["code"]).to eq("validation_failed")
      end
    end
  end

  describe "PUT /api/v1/admin/products/:id" do
    let!(:product) { create(:product, brand: brand, name: "Old Name") }

    it "updates the product details" do
      put "/api/v1/admin/products/#{product.id}", params: { brand_id: brand.id, name: "New Name" }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(product.reload.name).to eq("New Name")
    end
  end

  describe "PUT /api/v1/admin/products/:id/update_status" do
    let!(:product) { create(:product, brand: brand, status: :inactive) }

    it "updates the product status" do
      put "/api/v1/admin/products/#{product.id}/update_status", params: { brand_id: brand.id, status: "active" }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(product.reload.status).to eq("active")
    end
  end

  describe "DELETE /api/v1/admin/products/:id" do
    let!(:product) { create(:product, brand: brand) }

    it "deletes the product" do
      expect {
        delete "/api/v1/admin/products/#{product.id}", params: { brand_id: brand.id }, headers: headers
      }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
