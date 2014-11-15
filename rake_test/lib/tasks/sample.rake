namespace :sample do           # ネームスペースを定義 "rake sample: ..."となる
  desc "サンプルデータを作成する"    # rake -T のタスク一覧の結果で表示されるタスクの説明文
  task populate: :environment do # タスク名を定義 "rake db:populate"で呼べる
    # 100ユーザ作成する
    100.times do |n|
      nickname = "nickname#{n}"
      email    = "user#{n}@example.co.jp"
      password = "password"
      User.create!(nickname: nickname, email: email, password: password)
    end
  end
end
