category1 = Category.create! name: 'デスクトップパソコン'
category1.products.create! name: "高いパソコン", desc: "高いだけありHigh Specなパソコンです"
category1.products.create! name: "安いパソコン", desc: "とにかく安さだけを追求したパソコンです"

category2 = Category.create! name: 'ノートパソコン'
category2.products.create! name: "小さいノートPC", desc: "小さいノートPCです"
category2.products.create! name: "大きいノートPC", desc: "大きいノートPCです"
category2.products.create! name: "High SpecノートPC", desc: "性能がよいノートPCです"

category3 = Category.create! name: "スマホ"
category3.products.create! name: "High Specスマホ", desc: "High Specなスマホです"
category3.products.create! name: "普通のスマホ", desc: "スマホです"
