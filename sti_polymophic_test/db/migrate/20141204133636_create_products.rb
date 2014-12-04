class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :maker_id
      t.integer :cpu_id
      t.integer :author_id

      t.timestamps
    end
  end
end
