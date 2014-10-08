# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

carrier1 = Carrier.create!(name: "Mocodo")
carrier2 = Carrier.create!(name: "BankSoft")

carrier1.products.create!(
  name: "iPhone 6",
  description: "今回のモデルチェンジではいくつか見どころがあるが、その中でも特に大きなポイントとなるのが画面サイズのアップだ。「iPhone 6」は4.7インチ、「iPhone 6 Plus」は5.5インチの「Retina HDディスプレイ」を採用している。従来モデル「iPhone 5s」の4インチと比べて、「iPhone 6」はひと回り、「iPhone 6 Plus」ではそれ以上に大きなディスプレイとなっている。",
  price: 96480,
  discontinued: false)

carrier1.products.create!(
  name: "iPhone 3G",
  description: "iPhone 3Gとはアップル インコーポレイテッドが設計・販売しているスマートフォンである。iPhoneの第2世代機で、2008年6月9日にサンフランシスコのモスコーニ・センター（英語版）で開催されたWWDC 2008で発表された。",
  price: 12800,
  discontinued: true)

carrier2.products.create!(
  name: "AQUOS CRYSTAL SoftBank",
  description: "画面のフレームを極限までなくした「フレームレス構造」によって、画面だけを持っているような感覚を実現したスマートフォン。ディスプレイは大画面の5.0型「S-CG Silicon」（1280×720ドット）液晶を搭載しながら、女性でも片手で操作できるコンパクトなサイズに仕上げている。",
  price: 8800,
  discontinued: false)
