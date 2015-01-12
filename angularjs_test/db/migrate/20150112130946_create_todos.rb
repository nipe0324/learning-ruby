class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.integer :todo_list_id
      t.string :description
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
