class Brand < ApplicationRecord
  validates :name, presence: true
  has_many :products

  enum status: { inactive: 0, active: 1 }, _prefix: true
end
