class Product < ApplicationRecord
  validates :brand_id, presence: true
  validates :name, presence: true

  enum status: { active: 0, inactive: 1 }, _prefix: true

  belongs_to :brand
end
