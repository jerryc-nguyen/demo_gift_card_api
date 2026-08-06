require 'rails_helper'
require 'csv'

RSpec.describe Clients::CsvGenerators::CancelReport do
  let(:client) { create(:client) }
  let(:product) { create(:product) }
  let!(:card) { create(:gift_card, client: client, product: product, status: :cancelled, amount: 15.0) }

  before do
    card.destroy # soft delete it so paranoia sets deleted_at
  end

  describe '#call' do
    it 'generates a CSV containing cancelled gift cards' do
      csv_string = described_class.new(client: client).call
      csv = CSV.parse(csv_string, headers: true)

      expect(csv.headers).to eq(["Activation Number", "Product Id", "Amount", "Cancel Date"])
      expect(csv.length).to eq(1)
      expect(csv[0]["Activation Number"]).to eq(card.activation_number)
      expect(csv[0]["Amount"].to_f).to eq(15.0)
      expect(csv[0]["Cancel Date"]).not_to be_nil
    end
  end
end
