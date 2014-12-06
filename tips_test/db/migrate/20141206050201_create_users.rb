class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :credit_card_number

      t.timestamps
    end
  end
end
