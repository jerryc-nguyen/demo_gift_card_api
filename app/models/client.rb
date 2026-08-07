class Client < ApplicationRecord
  audited
  
  has_many :client_products
  has_many :products, through: :client_products
  has_many :gift_cards

  validates :api_key, uniqueness: true
end
