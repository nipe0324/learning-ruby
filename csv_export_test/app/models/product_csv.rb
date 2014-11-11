module ProductCsv
  extend CsvExporter

  def self.query
    Product.all.limit(5)
  end

  def self.header
    ["ID", "商品名", "値段", "発売日", "製造元"]
  end

  def self.values(product)
    [product.id, product.name, product.price, product.released_on, product.manufacture.name]
  end
end
