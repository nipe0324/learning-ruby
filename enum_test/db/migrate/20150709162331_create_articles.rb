class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :status, default: 0, null: false, limit: 1

      t.timestamps null: false
    end

		add_index :articles, :status
  end
end
