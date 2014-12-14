FactoryGirl.define do
  factory :order do
    user

    factory :order_with_line_items do
      transient do
        line_items_count 5
      end

      after(:create) do |order, evaluator|
        create_list(:line_item, evaluator.line_items_count, order: order)
      end
    end
  end
end
