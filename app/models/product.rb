class Product < ApplicationRecord
  validates :brand_id, presence: true
  validates :name, presence: true

  enum status: { active: 0, inactive: 1 }, _prefix: true

  belongs_to :brand

  before_save :update_searchable_text

  scope :search, ->(query) { where("searchable_text LIKE ?", "%#{query}%") }

  private

  def update_searchable_text
    self.searchable_text = "#{name} #{brand.name}"
  end
end
