a = Manufacture.create! name: "Aエレクトリック"
%w(レコーダー イヤホン マイク).each do |name|
  random = [*1..5].sample  # 1-5からランダム値を取得
  a.products.create! name: name, price: random * 100, released_on: random.day.ago
end

b = Manufacture.create! name: "B工業"
%w(洗濯機 冷蔵庫 エアコン).each do |name|
  random = [*1..5].sample  # 1-5からランダム値を取得
  b.products.create! name: name, price: random * 10000, released_on: random.day.ago
end

c = Manufacture.create! name: "C電器"
%w(UltraノートPC 超HD40型TV 一眼デジタルカメラ).each do |name|
  random = [*1..5].sample  # 1-5からランダム値を取得
  c.products.create! name: name, price: random * 100000, released_on: random.day.ago
end
