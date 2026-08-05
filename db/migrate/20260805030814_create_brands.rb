class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.string :name, null: false
      t.string :website
      t.string :logo_url
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
