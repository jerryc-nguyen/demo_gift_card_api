require 'rails_helper'

RSpec.describe JwtService do
  describe '.encode and .decode' do
    let(:payload) { { 'client_id' => 123 } }

    it 'encodes a payload and decodes it back' do
      token = described_class.encode(payload)
      expect(token).to be_a(String)

      decoded = described_class.decode(token)
      expect(decoded).to include(payload)
    end

    it 'returns nil for invalid or expired token' do
      expect(described_class.decode('invalid-token')).to be_nil
    end
  end
end
