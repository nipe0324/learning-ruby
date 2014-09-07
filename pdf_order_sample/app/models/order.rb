class Order < ActiveRecord::Base
  has_many :line_items

  def total_price
    line_items.to_a.sum { |line_itme| line_itme.total_price }
  end
end
