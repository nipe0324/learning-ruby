# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"

    factory :user_with_posts do
      # ignoreブロックでDBの属性とは関係ない属性を定義
      # FactoryGirl 4.5以外以降はtransientブロックに変わるかも?
      ignore do
        posts_count 5
      end

      # userに関連したpostを作成する
      #   user - 作成されたuserインスタンス自身
      #   evaluator - transient属性を含むファクトリのすべての属性を保持
      #   create_listの第2引数は、作成する関連をもったレコードの数を指定する
      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
