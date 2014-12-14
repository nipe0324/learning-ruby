FactoryGirl.define do
  factory :line_item do
    product  { create(:product) }
    quantity { (1..10).to_a.sample }
  end
end
