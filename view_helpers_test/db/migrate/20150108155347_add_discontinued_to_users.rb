class AddDiscontinuedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :discontinued, :boolean
  end
end
