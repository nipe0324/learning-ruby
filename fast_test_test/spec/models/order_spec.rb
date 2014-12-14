require 'rails_helper'

RSpec.describe Order, :type => :model do

  describe "#total_price" do
    let(:order) { build_stubbed(:order, line_items: line_items) }

    subject { order.total_price }

    context "line_items = 0" do
      let(:line_items) { [] }
      it { is_expected.to eq 0 }
    end

    context "line_items = 1" do
      let(:product)    { build_stubbed(:product, price: 100) }
      let(:line_items) do
        [
          build_stubbed(:line_item, product: product, quantity: 2)
        ]
      end
      it { is_expected.to eq 200 }
    end

    context "line_items = 2" do
      let(:product1)    { build_stubbed(:product, price: 100) }
      let(:product2)    { build_stubbed(:product, price: 100) }
      let(:line_items) do
        [
          build_stubbed(:line_item, product: product1, quantity: 2),
          build_stubbed(:line_item, product: product1, quantity: 2)
        ]
      end
      it { is_expected.to eq 400 }
    end
  end
end
