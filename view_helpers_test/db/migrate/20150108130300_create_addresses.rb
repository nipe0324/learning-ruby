class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :zipcode
      t.string :city
      t.string :tel

      t.timestamps null: false
    end
  end
end
