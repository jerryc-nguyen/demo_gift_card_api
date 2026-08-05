class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.belongs_to :brand, null: false
      t.string :name
      t.decimal :price
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
