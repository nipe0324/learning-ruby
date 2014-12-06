class Product < ActiveRecord::Base
  belongs_to :category

  validates :name,        presence: true
  validates :price,       presence: true
  validates :category_id, presence: true

  before_validation :calculate_price

  # def to_param
  #   "#{id}-#{name}"
  # end
end
