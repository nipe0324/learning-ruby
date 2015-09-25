class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :pref_id
      t.string :name
      t.string :name_kana
      t.string :property

      t.timestamps null: false
    end
  end
end
