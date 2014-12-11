# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "My Awesome Product"

    trait :published do
      published true
      published_at Time.zone.now
    end

    trait :unpublished do
      published false
      published_at nil
    end

    trait :week_long_publishing do
      start_at { 1.week.ago }
      end_at   { Time.now }
    end

    trait :month_long_publishing do
      start_at { 1.month.ago }
      end_at   { Time.now }
    end

    # traitsでグループ化する
    factory :week_long_published_product,    traits: [:published, :week_long_publishing]
    factory :month_long_published_product,   traits: [:published, :month_long_publishing]
    factory :week_long_unpublished_product,  traits: [:unpublished, :week_long_publishing]
    factory :month_long_unpublished_product, traits: [:unpublished, :month_long_publishing]
  end
end
