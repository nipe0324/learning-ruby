require 'rails_helper'

RSpec.describe Product, :type => :model do
  describe "#name" do
    it "空文字を許容しないこと" do
      product = Product.new(name: "", price: 100, discontinued: false)
      expect(product).to be_invalid
    end
  end
end
