class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.date :released_on
      t.references :manufacture, index: true

      t.timestamps
    end
  end
end
