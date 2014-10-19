class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.boolean :discontinued

      t.timestamps
    end
  end
end
