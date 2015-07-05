class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :remote_tag_id

      t.timestamps null: false
    end
  end
end
