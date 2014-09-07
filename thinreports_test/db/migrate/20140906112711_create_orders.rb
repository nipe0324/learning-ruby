class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
