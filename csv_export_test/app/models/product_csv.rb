module ProductCsv
  extend CsvExporter


  class << self
    def query
      Product.all.limit(5)
    end

    def header
      ["ID", "商品名", "値段", "発売日", "製造元"]
    end

    def row(product)
      [product.id, product.name, product.price, product.released_on, product.manufacture.name]
    end
  end
end
