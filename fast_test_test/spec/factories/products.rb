FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "MyString#{n}" }
    price 100
    published true
  end

end
