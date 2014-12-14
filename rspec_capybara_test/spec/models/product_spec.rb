require 'rails_helper'

RSpec.describe Product, :type => :model do

  it "#total_price" do
    product = Product.build
    allow(product).to receive(:discount).with(5)

    # product = build(:product)
    # allow(Product).to receive(:count).and_return(5)
    # p Product.count
    # line_item1 = build_stubbed(:line_item)
    # line_item2 = build_stubbed(:line_item)

    # allow(line_item1).to receive(:total_price).and_return(100)
    # allow(line_item2).to receive(:total_price).and_return(200)

    # order = build(:order, line_items: [line_item1, line_item2])
    # expect(order.total_price).to eq 300
  end
end
