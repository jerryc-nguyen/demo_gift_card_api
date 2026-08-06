require 'rails_helper'

RSpec.describe "Api::V1::Admin::Clients", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{JwtService.encode(user_id: user.id)}" } }

  describe "POST /api/v1/admin/clients" do
    it "creates a client and generates an api key" do
      expect {
        post "/api/v1/admin/clients", params: { name: "Client XYZ", payout_rate: 0.9 }, headers: headers
      }.to change(Client, :count).by(1)

      expect(response).to have_http_status(:ok)
      client = Client.last
      expect(client.name).to eq("Client XYZ")
      expect(client.payout_rate.to_f).to eq(0.9)
      expect(client.api_key).to be_present
    end
  end

  describe "PUT /api/v1/admin/clients/:id" do
    let!(:client) { create(:client, name: "Old Name") }

    it "updates the client" do
      put "/api/v1/admin/clients/#{client.id}", params: { name: "New Name" }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(client.reload.name).to eq("New Name")
    end
  end

  describe "DELETE /api/v1/admin/clients/:id" do
    let!(:client) { create(:client) }

    it "deletes the client" do
      expect {
        delete "/api/v1/admin/clients/#{client.id}", headers: headers
      }.to change(Client, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
