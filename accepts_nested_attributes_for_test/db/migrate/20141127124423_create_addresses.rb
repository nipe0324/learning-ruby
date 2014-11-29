class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :zipcode
      t.string :city
      t.string :street
      t.string :tel

      t.timestamps
    end
  end
end
