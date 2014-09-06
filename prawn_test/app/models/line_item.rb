class LineItem < ActiveRecord::Base
  belongs_to :order

  def total_price
    return price * quantity
  end
end
