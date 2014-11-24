class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name
      t.boolean :complete, default: false, null: false

      t.timestamps
    end
  end
end
