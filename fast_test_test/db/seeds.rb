FactoryGirl.create_list(:product, 10)
5.times { FactoryGirl.create(:order_with_line_items) }
