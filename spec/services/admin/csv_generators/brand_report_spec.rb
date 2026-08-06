require 'rails_helper'
require 'csv'

RSpec.describe Admin::CsvGenerators::BrandReport do
  let!(:brand) { create(:brand, name: 'Brand A') }
  let(:product) { create(:product, brand: brand) }
  let!(:card) { create(:gift_card, product: product, status: :active, amount: 20.0) }

  describe '#call' do
    it 'generates a CSV containing brand statistics' do
      csv_string = described_class.new.call
      csv = CSV.parse(csv_string, headers: true)

      expect(csv.headers).to eq(["Brand ID", "Brand Name", "Products Sold", "Total Sold Amount"])
      expect(csv.length).to eq(1)
      expect(csv[0]["Brand Name"]).to eq('Brand A')
      expect(csv[0]["Products Sold"]).to eq('1')
      expect(csv[0]["Total Sold Amount"]).to eq('20.0')
    end
  end
end
