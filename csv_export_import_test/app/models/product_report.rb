class ProductReport
  include ActiveModel::Model

  def self.attribute_names
    [
      :id,                  # 1. 商品ID
      :name,                # 2. 商品名
      :price,               # 3. 値段
      :released_on,         # 4. 発売日
      :manufacture_name,    # 5. 製造元名
      :created_at,          # 6. 作成時刻
      :updated_at           # 7. 更新時刻
    ]
  end

  attr_accessor(*attribute_names)

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def attributes
    {
      :id => id,
      :name => name,
      :price => price,
      :released_on => released_on,
      :manufacture_name => manufacture_name,
      :created_at => created_at,
      :updated_at => updated_at
    }
  end

  def self.to_csv(report_products, options = {})
    CSV.generate(options) do |csv|
      csv << ProductReport.attribute_names
      report_products.each do |report_product|
        csv << report_product.attributes.values_at(*ProductReport.attribute_names)
      end
    end
  end

  def self.all
    report_products = []

    products = Product.includes(:manufacture)
    products.each do |product|
      # productの値の配列を取得
      array = product.attributes.values_at(*Product.column_names)
      # replacement
      array[4] = product.manufacture.name

      # ハッシュを作成
      report_product = self.new(Hash[[attribute_names, array].transpose])
      report_products << report_product
    end

    report_products
  end
end
