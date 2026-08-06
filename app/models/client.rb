class Client < ApplicationRecord
  has_many :client_products
  has_many :products, through: :client_products
  has_many :gift_cards
  validates :api_key, uniqueness: true

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
  end

end
