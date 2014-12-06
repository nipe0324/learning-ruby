class AddPublishedOnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :published_on, :datetime
  end
end
