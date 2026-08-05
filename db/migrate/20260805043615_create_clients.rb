class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :api_key
      t.decimal :payout_rate
      t.timestamps
    end
    add_index :clients, :api_key, unique: true
  end
end
