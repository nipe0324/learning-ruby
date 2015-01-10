class AddLockVersionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :lock_version, :integer, defualt: 0
  end
end
