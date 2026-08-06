require 'rails_helper'

RSpec.describe Clients::Queries::CatalogBrands do
  let!(:brand1) { create(:brand, name: 'Apple', status: :active) }
  let!(:brand2) { create(:brand, name: 'Google', status: :inactive) }
  let(:scope) { Brand.all }

  describe '#call' do
    it 'searches brands by query' do
      query = described_class.new(scope, { query: 'App' })
      expect(query.call).to contain_exactly(brand1)
    end

    it 'filters brands by status' do
      query = described_class.new(scope, { status: 'inactive' })
      expect(query.call).to contain_exactly(brand2)
    end

    it 'returns all brands when no params are given' do
      query = described_class.new(scope, {})
      expect(query.call).to contain_exactly(brand1, brand2)
    end
  end
end
