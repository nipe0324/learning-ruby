class AddToPrefectureIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prefecture_id, :integer
  end
end
