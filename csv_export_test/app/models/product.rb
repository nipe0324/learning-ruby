class Product < ActiveRecord::Base
  belongs_to :manufacture

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << csv_column_names
      all.each do |product|
        csv << product.csv_column_values
      end
    end
  end

  def self.csv_column_names
    ["ID", "商品名", "値段", "発売日", "製造元"]
  end

  def csv_column_values
    [id, name, price, released_on, manufacture.name]
  end
end
