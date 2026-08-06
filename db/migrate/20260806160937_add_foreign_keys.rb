class AddForeignKeys < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :products, :brands, on_delete: :cascade
    
    add_foreign_key :client_products, :clients, on_delete: :cascade
    add_foreign_key :client_products, :products, on_delete: :cascade

    add_foreign_key :gift_cards, :products, on_delete: :restrict
    add_foreign_key :gift_cards, :clients, on_delete: :restrict
  end
end
