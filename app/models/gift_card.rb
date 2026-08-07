class GiftCard < ApplicationRecord
  audited
  acts_as_paranoid

  belongs_to :product
  belongs_to :client

  enum status: { active: 0, cancelled: 1 }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  
end
