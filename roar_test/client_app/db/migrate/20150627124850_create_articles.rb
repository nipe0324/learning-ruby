class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :remote_tweet_id

      t.timestamps null: false
    end
  end
end
