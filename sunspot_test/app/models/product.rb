class Product < ActiveRecord::Base
  belongs_to :category

  searchable do
    text :name, :desc

    integer :category_id
    time :created_at
  end
end
