require 'rails_helper'

RSpec.describe "Api::V1::Clients::GiftCards", type: :request do
  let(:client) { create(:client) }
  let(:headers) { { "X-Api-Key" => client.api_key } }
  let(:brand) { create(:brand) }
  let!(:product) { create(:product, brand: brand, status: :active) }

  before do
    create(:client_product, client: client, product: product)
  end

  describe "POST /api/v1/clients/gift_cards" do
    context "with valid parameters" do
      it "creates a new gift card" do
        expect {
          post "/api/v1/clients/gift_cards",
               params: { product_id: product.id, pin: "1234", purchase_details: "Details" },
               headers: headers
        }.to change(GiftCard, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["activation_number"]).to be_present
      end
    end
  end

  describe "DELETE /api/v1/clients/gift_cards/:id" do
    let!(:gift_card) { create(:gift_card, client: client, product: product) }

    it "cancels/soft-deletes the gift card" do
      expect {
        delete "/api/v1/clients/gift_cards/#{gift_card.activation_number}", headers: headers
      }.to change(GiftCard, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(gift_card.reload.status).to eq("cancelled")
    end
  end
end
