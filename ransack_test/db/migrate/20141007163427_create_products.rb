class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.boolean :discontinued
      t.integer :carrier_id

      t.timestamps
    end
  end
end
