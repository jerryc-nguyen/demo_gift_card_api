require 'rails_helper'

RSpec.describe Admin::Queries::ClientReport do
  let!(:client1) { create(:client, name: 'Client A') }
  let!(:client2) { create(:client, name: 'Client B') }

  let!(:card1) { create(:gift_card, client: client1, status: :active, amount: 20.0) }
  let!(:card2) { create(:gift_card, client: client1, status: :active, amount: 30.0) }
  let!(:card3) { create(:gift_card, client: client1, status: :cancelled, amount: 50.0) }
  let!(:card4) { create(:gift_card, client: client2, status: :cancelled, amount: 15.0) }

  describe '#call' do
    it 'returns the clients sorted by name with correct products_sold and total_amount' do
      report = described_class.new.call

      client_a_data = report.find { |c| c.id == client1.id }
      client_b_data = report.find { |c| c.id == client2.id }

      expect(client_a_data.products_sold).to eq(2)
      expect(client_a_data.total_amount.to_f).to eq(50.0)

      expect(client_b_data.products_sold).to eq(0)
      expect(client_b_data.total_amount.to_f).to eq(0.0)
    end
  end
end
