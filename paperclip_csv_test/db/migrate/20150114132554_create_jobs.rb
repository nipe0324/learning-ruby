class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :priority

      t.timestamps null: false
    end
  end
end
