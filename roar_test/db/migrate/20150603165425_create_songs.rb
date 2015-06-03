class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :length_sec
      t.integer :album_id
      t.integer :singer_id

      t.timestamps null: false
    end
  end
end
