10.times do |i|
  user = User.create name: "ユーザー名#{i}"
  user.posts.create title: "タイトル#{i}", content: "本文#{i}"
end

