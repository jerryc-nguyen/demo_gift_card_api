require 'rails_helper'

RSpec.describe "Api::V1::Admin::ClientProducts", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{JwtService.encode(user_id: user.id)}" } }
  let(:client) { create(:client) }
  let(:brand) { create(:brand) }
  let!(:product1) { create(:product, brand: brand) }
  let!(:product2) { create(:product, brand: brand) }

  describe "POST /api/v1/admin/client_products/bulk_assign" do
    it "assigns products to the client" do
      expect {
        post "/api/v1/admin/client_products/bulk_assign",
             params: { client_id: client.id, product_ids: [product1.id, product2.id] },
             headers: headers
      }.to change(ClientProduct, :count).by(2)

      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /api/v1/admin/client_products/bulk_remove" do
    before do
      create(:client_product, client: client, product: product1)
      create(:client_product, client: client, product: product2)
    end

    it "removes products from the client" do
      expect {
        delete "/api/v1/admin/client_products/bulk_remove",
               params: { client_id: client.id, product_ids: [product1.id, product2.id] },
               headers: headers
      }.to change(ClientProduct, :count).by(-2)

      expect(response).to have_http_status(:ok)
    end
  end
end
