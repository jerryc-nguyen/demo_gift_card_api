require 'rails_helper'

RSpec.describe Clients::Queries::CancelGiftCards do
  let(:client) { create(:client) }
  let!(:card1) { create(:gift_card, client: client, status: :cancelled) }
  let!(:card2) { create(:gift_card, client: client, status: :active) }
  let!(:card3) { create(:gift_card, client: client, status: :cancelled) }
  let!(:other_client_card) { create(:gift_card, status: :cancelled) }

  describe '#call' do
    it 'returns cancelled gift cards for the client (including soft-deleted ones)' do
      card1.destroy # soft delete using paranoia
      
      query = described_class.new(client: client)
      results = query.call
      
      expect(results).to include(card1, card3)
      expect(results).not_to include(card2, other_client_card)
    end
  end
end
