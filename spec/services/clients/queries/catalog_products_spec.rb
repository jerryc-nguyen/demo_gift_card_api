require 'rails_helper'

RSpec.describe Clients::Queries::CatalogProducts do
  let(:client) { create(:client) }
  let(:brand1) { create(:brand, name: 'Apple') }
  let(:brand2) { create(:brand, name: 'Google') }

  let!(:product1) { create(:product, brand: brand1, name: 'iPhone 15', price: 999.0, status: :active) }
  let!(:product2) { create(:product, brand: brand1, name: 'iPad Pro', price: 799.0, status: :active) }
  let!(:product3) { create(:product, brand: brand2, name: 'Pixel 8', price: 699.0, status: :active) }
  let!(:product4) { create(:product, brand: brand2, name: 'Pixel Watch', price: 349.0, status: :inactive) }

  before do
    client.products << [product1, product2, product3, product4]
  end

  describe '#call' do
    it 'filters products by query search' do
      query = described_class.new(client.products, { query: 'iPhone' })
      expect(query.call).to contain_exactly(product1)
    end

    it 'filters products by min_price' do
      query = described_class.new(client.products, { min_price: '700' })
      expect(query.call).to contain_exactly(product1, product2)
    end

    it 'filters products by max_price' do
      query = described_class.new(client.products, { max_price: '700' })
      expect(query.call).to contain_exactly(product3, product4)
    end

    it 'filters products by brand_ids' do
      query = described_class.new(client.products, { brand_ids: [brand2.id] })
      expect(query.call).to contain_exactly(product3, product4)
    end

    it 'combines multiple filters' do
      query = described_class.new(
        client.products,
        { query: 'Pixel', min_price: '500', brand_ids: [brand2.id] }
      )
      expect(query.call).to contain_exactly(product3)
    end
  end
end
