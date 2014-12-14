class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :unit_price
      t.integer :quantity

      t.timestamps
    end
  end
end
