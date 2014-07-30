class Category < ActiveRecord::Base
  has_many :categorizastions
  has_many :products, through: :categorizastions
end
