require 'rails_helper'
require 'csv'

RSpec.describe Admin::CsvGenerators::ClientReport do
  let!(:client) { create(:client, name: 'Client A') }
  let!(:card) { create(:gift_card, client: client, status: :active, amount: 30.0) }

  describe '#call' do
    it 'generates a CSV containing client statistics' do
      csv_string = described_class.new.call
      csv = CSV.parse(csv_string, headers: true)

      expect(csv.headers).to eq(["Client ID", "Client Name", "Products Bought", "Total Bought Amount"])
      expect(csv.length).to eq(1)
      expect(csv[0]["Client Name"]).to eq('Client A')
      expect(csv[0]["Products Bought"]).to eq('1')
      expect(csv[0]["Total Bought Amount"]).to eq('30.0')
    end
  end
end
