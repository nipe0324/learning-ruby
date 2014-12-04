class Product < ActiveRecord::Base
  belongs_to :cpu
  belongs_to :maker
  belongs_to :author

  validates :name,  presence: true
  validates :price, presence: true
  validates :type,  presence: true
end
