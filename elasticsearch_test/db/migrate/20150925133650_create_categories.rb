class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :name_kana
      t.integer :parent1
      t.integer :parent2
      t.string :similar

      t.timestamps null: false
    end
  end
end
