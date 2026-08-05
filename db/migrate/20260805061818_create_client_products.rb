class CreateClientProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :client_products do |t|
      t.belongs_to :client, null: false
      t.belongs_to :product, null: false
      t.timestamps
    end

    add_index :client_products, [:client_id, :product_id], unique: true
  end
end
