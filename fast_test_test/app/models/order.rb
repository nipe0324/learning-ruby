class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  def total_price
    line_items.map(&:total_price).sum
  end
end
