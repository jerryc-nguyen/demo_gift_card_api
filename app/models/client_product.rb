class ClientProduct < ApplicationRecord
  audited
  belongs_to :client
  belongs_to :product
  
  validates :product_id, uniqueness: { scope: :client_id, message: "already assigned to this client" }
end
