class Order < ActiveRecord::Base
  has_many :line_items

  def total_price
    sum = 0
    line_items.map { |line_itme| sum += line_itme.total_price }
    return sum
  end
end
