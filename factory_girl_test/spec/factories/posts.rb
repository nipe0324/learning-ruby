# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence(:title)   { |n| "MyString#{n}" }
    sequence(:content) { |n| "MyText#{n}"   }
#    user
    # association :user, name: "Marin", sex: "female"
  end
end
