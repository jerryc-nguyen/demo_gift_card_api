class CreateGiftCards < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_cards do |t|
      t.belongs_to :product, index: true
      t.belongs_to :client, index: true
      t.string :activation_number
      t.string :pin
      t.string :purchase_details
      t.integer :status, default: 0
      t.decimal :amount
      t.timestamps
    end

    add_index :gift_cards, :activation_number, unique: true
  end
end
