class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.integer :owner_id

      t.timestamps
    end

    add_index :task_lists, :owner_id
  end
end
