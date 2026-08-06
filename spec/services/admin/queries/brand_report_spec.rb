require 'rails_helper'

RSpec.describe Admin::Queries::BrandReport do
  let!(:brand1) { create(:brand, name: 'Brand A') }
  let!(:brand2) { create(:brand, name: 'Brand B') }

  let(:product1) { create(:product, brand: brand1) }
  let(:product2) { create(:product, brand: brand2) }

  let!(:card1) { create(:gift_card, product: product1, status: :active, amount: 20.0) }
  let!(:card2) { create(:gift_card, product: product1, status: :active, amount: 30.0) }
  let!(:card3) { create(:gift_card, product: product1, status: :cancelled, amount: 50.0) }
  let!(:card4) { create(:gift_card, product: product2, status: :cancelled, amount: 15.0) }

  describe '#call' do
    it 'returns the brands sorted by name with correct products_sold and total_amount' do
      report = described_class.new.call

      brand_a_data = report.find { |b| b.id == brand1.id }
      brand_b_data = report.find { |b| b.id == brand2.id }

      expect(brand_a_data.products_sold).to eq(2)
      expect(brand_a_data.total_amount.to_f).to eq(50.0)

      expect(brand_b_data.products_sold).to eq(0)
      expect(brand_b_data.total_amount.to_f).to eq(0.0)
    end
  end
end
