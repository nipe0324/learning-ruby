class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :property
      t.string :alphabet
      t.string :name_kana
      t.integer :pref_id
      t.integer :area_id
      t.integer :station_id1
      t.integer :station_time1
      t.integer :station_distance1
      t.integer :station_id2
      t.integer :station_time2
      t.integer :station_distance2
      t.integer :station_id3
      t.integer :station_time3
      t.integer :station_distance3
      t.integer :category_id1
      t.integer :category_id2
      t.integer :category_id3
      t.integer :category_id4
      t.integer :category_id5
      t.string :zip
      t.string :address
      t.float :north_latitude
      t.float :east_longitude
      t.text :description
      t.integer :purpose
      t.integer :open_morning
      t.integer :open_lunch
      t.integer :open_late
      t.integer :photo_count
      t.integer :special_count
      t.integer :menu_count
      t.integer :fan_count
      t.integer :access_count
      t.datetime :created_on
      t.datetime :modified_on
      t.boolean :closed

      t.timestamps null: false
    end
  end
end
