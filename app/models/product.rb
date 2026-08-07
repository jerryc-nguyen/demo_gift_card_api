class Product < ApplicationRecord
  audited
  
  validates :brand_id, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  enum status: { active: 0, inactive: 1 }, _prefix: true

  has_many :gift_cards, dependent: :destroy
  belongs_to :brand
  before_save :update_searchable_text

  scope :search, ->(query) { where("searchable_text LIKE ?", "%#{query}%") }

  private

  def update_searchable_text
    self.searchable_text = "#{name} #{brand.name}"
  end
end
