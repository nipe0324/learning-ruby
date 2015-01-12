class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
