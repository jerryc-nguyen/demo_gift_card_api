require 'rails_helper'

RSpec.describe "Api::V1::Clients::Brands", type: :request do
  let(:client) { create(:client) }
  let(:headers) { { "X-Api-Key" => client.api_key } }
  let(:brand) { create(:brand) }
  let!(:product) { create(:product, brand: brand, status: :active) }

  before do
    create(:client_product, client: client, product: product)
  end

  describe "GET /api/v1/clients/brands" do
    it "returns active brands that client has active products in" do
      get "/api/v1/clients/brands", headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["records"]).to be_an(Array)
      expect(json["meta"]["total_count"]).to eq(1)
    end
  end

  describe "GET /api/v1/clients/brands/:id" do
    it "returns the brand details and filtered products" do
      get "/api/v1/clients/brands/#{brand.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["brand"]["id"]).to eq(brand.id)
      expect(json["products"]).to be_an(Array)
      expect(json["meta"]["total_count"]).to eq(1)
    end
  end
end
