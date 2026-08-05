class Product < ApplicationRecord
  validates :brand_id, presence: true
  validates :name, presence: true
end
