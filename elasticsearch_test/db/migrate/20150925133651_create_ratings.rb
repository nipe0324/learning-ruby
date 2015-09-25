class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.integer :total
      t.integer :food
      t.integer :service
      t.integer :atmosphere
      t.integer :cost_performance
      t.string :title
      t.text :body
      t.integer :purpose
      t.datetime :created_on

      t.timestamps null: false
    end
  end
end
