require 'rails_helper'

RSpec.describe Clients::Queries::SpendingGiftCards do
  let(:client) { create(:client) }
  let!(:card1) { create(:gift_card, client: client, status: :active) }
  let!(:card2) { create(:gift_card, client: client, status: :cancelled) }
  let!(:other_client_card) { create(:gift_card, status: :active) }

  describe '#call' do
    it 'returns active spending gift cards for the client' do
      query = described_class.new(client: client)
      results = query.call
      
      expect(results).to include(card1)
      expect(results).not_to include(card2, other_client_card)
    end
  end
end
