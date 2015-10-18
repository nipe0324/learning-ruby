ActiveRecord::Base.transaction do
  # すべてのレコードを削除する
  [Category, Pref, Restaurant].each(&:delete_all)

  # カテゴリの作成(3件)
  teisyoku = Category.create!(name: '定食',      name_kana: 'ていしょく')
  italian = Category.create!(name: 'イタリアン', name_kana: 'いたりあん')
  izakaya = Category.create!(name: '居酒屋',    name_kana: 'いざかや')

  # 都道府県の作成(2件)
  tokyo = Pref.create!(name: '東京都')
  kanagawa = Pref.create!(name: '神奈川県')

  # レストラン作成(各カテゴリ, 都道府県の掛け算で6件)
  restaurants = [
    {
      name: '松屋', name_kana: 'まつや', zip: '240-0113', address: '三浦郡葉山町堀内24-3',
      pref: tokyo, category: teisyoku, closed: false
    },
    {
      name: 'ラ・マーレ・ド・茶屋', name_kana: 'らまーれどちゃや', zip: '142-0111', address: '港区六本木1-1-1',
      pref: kanagawa, category: teisyoku, closed: false
    },
    {
      name: 'レストラン シェ・リュイ', name_kana: 'しぇりゅい', zip: '150-0033', address: '渋谷区猿楽町11-11',
      pref: tokyo, category: italian, closed: false
    },
    {
      name: 'スパゲティ　ハシヤ', name_kana: 'はしや', zip: '162-0023', address: '三浦1-11',
      pref: kanagawa, category: italian, closed: true
    },
    {
      name: '牛角', name_kana: 'ぎゅうかく', zip: '130-0033', address: '池袋3-33',
      pref: tokyo, category: izakaya, closed: false
    },
    {
      name: '沖縄そば やんばる', name_kana: 'おきなわそばやんばる', zip: '231-0011', address: '西区横浜1-11',
      pref: kanagawa, category: izakaya, closed: true
    }
  ] * 100 # 600件(6件 x 100)のデータを作成
  Restaurant.create!(restaurants)
end
