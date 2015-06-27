class AddTweetIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tweet_id, :integer
  end
end
