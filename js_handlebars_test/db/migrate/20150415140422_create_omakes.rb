class CreateOmakes < ActiveRecord::Migration
  def change
    create_table :omakes do |t|
      t.string :name
      t.integer :price
      t.integer :weight

      t.timestamps null: false
    end
  end
end
