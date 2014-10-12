class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description, null: false
      t.integer :priority
      t.date :due_date
      t.boolean :completed,  null: false, default: false
      t.integer :list_id,    null: false

      t.timestamps
    end
  end
end
