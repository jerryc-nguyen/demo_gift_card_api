class GiftCard < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :product
  belongs_to :client

  enum status: { active: 0, cancelled: 1 }
end
