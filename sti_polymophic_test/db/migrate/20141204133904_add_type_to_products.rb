class AddTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type, :string
    add_index  :products, :type
  end
end
