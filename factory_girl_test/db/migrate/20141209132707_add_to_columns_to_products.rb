class AddToColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :published, :boolean
    add_column :products, :published_at, :datetime
    add_column :products, :start_at, :datetime
    add_column :products, :end_at, :datetime
  end
end
