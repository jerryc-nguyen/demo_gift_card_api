class AddDeletedAtToGiftCard < ActiveRecord::Migration[7.1]
  def change
    add_column :gift_cards, :deleted_at, :datetime
    add_index :gift_cards, :deleted_at
  end
end
