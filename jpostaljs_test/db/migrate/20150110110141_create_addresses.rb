class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :zipcode
      t.integer :prefecture_id
      t.string :city
      t.string :street
      t.string :building

      t.timestamps null: false
    end
  end
end
