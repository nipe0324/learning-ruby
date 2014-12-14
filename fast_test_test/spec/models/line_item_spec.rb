require 'rails_helper'

RSpec.describe LineItem, :type => :model do
  describe "#total_price" do
    let(:product)   { build_stubbed(:product, price: 100)}
    let(:line_item) { build_stubbed(:line_item, product: product, quantity: quantity) }

    subject { line_item.total_price }

    context "quantity = 0" do
      let(:quantity) { 0 }
      it { is_expected.to eq 0 }
    end

    context "quantity = 1" do
      let(:quantity) { 1 }
      it { is_expected.to eq 100 }
    end

    context "quantity = 2" do
      let(:quantity) { 2 }
      it { is_expected.to eq 200 }
    end
  end
end
