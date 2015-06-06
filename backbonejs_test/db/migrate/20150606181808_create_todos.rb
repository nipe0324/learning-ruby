class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.integer :position
      t.references :list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
