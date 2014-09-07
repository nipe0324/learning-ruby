class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.date :released_on
      t.integer :rating
      t.boolean :discontinued, default: false, null: false
      t.references :publisher, index: true

      t.timestamps
    end
  end
end
