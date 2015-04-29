class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :name
      t.string :name_kana
      t.integer :price
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
