class CreateRatingVotes < ActiveRecord::Migration
  def change
    create_table :rating_votes do |t|
      t.integer :rating_id
      t.string :user
      t.datetime :created_on

      t.timestamps null: false
    end
  end
end
