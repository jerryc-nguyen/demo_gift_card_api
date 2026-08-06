require 'rails_helper'

RSpec.describe "Api::V1::Clients::Products", type: :request do
  let(:client) { create(:client) }
  let(:headers) { { "X-Api-Key" => client.api_key } }
  let(:brand) { create(:brand) }
  let!(:product) { create(:product, brand: brand) }

  before do
    create(:client_product, client: client, product: product)
  end

  describe "GET /api/v1/clients/products" do
    it "returns the list of client products with pagination" do
      get "/api/v1/clients/products", headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["records"]).to be_an(Array)
      expect(json["meta"]["total_count"]).to eq(1)
    end
  end
end
