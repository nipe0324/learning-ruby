class AddRateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rate, :integer
  end
end
