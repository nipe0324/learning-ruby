class ProductReport

  include ActiveModel::Model

  attr_accessor :file


  validates :file, presence: true
  # TODO: 拡張子, ファイルサイズの確認をいれる(fileがnilのときも動くように)

  def initialize(file = nil)
    self.file = file
  end

  def download(options = {})
    # Query
    products = Product.includes(:manufacture)

    # Create CSV
    CSV.generate(options) do |csv|
      csv << %w(商品ID 商品名 値段 発売日 製造元名)

      products.find_each do |product|
        row = ProductReport::Row.new(product: product, manufacture: product.manufacture)
        csv << row.to_csv
      end
    end
  end
File.extname(file.original_filename)
  def import
    return false unless valid?

    if imported_products_rows.map(&:valid?).all? && imported_products_rows.map(&:attrs_valid?).all?
      ActiveRecord::Base.transaction do
        imported_products_rows.each(&:save!)
      end
      true
    else
      imported_products_rows.each_with_index do |product_row, index|
        product_row.errors.full_messages.each do |message|
          errors.add :base, "列 #{index+1}: #{message}"
        end
        if product_row.product
          product_row.product.errors.full_messages.each do |message|
            errors.add :base, "列 #{index+1}: #{message}"
          end
        end
        if product_row.manufacture
          product_row.manufacture.errors.full_messages.each do |message|
            errors.add :base, "列 #{index+1}: #{message}"
          end
        end
      end
      false
    end
  end

  private

    def imported_products_rows
      @imported_products_rows ||= load_imported_products_rows
    end

    def load_imported_products_rows
      spreadsheet = open_spreadsheet
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]

        product       = Product.find_by_id(row["商品ID"])
        product.name  = row["商品名"]
        product.price = row["値段"]
        product.released_on = row["発売日"]

        manufacture = Manufacture.find_by_name(row["製造元名"])
        product.manufacture_id = manufacture.try(:id)

        ProductReport::Row.new(product: product, manufacture: manufacture)
      end
    end

    def open_spreadsheet
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::EXCEL.new(file.path)
      when ".xlsx" then Roo::EXCELX.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end



  class Row
    include ActiveModel::Model

    attr_accessor :product, :manufacture

    validates :product,     presence: true
    validates :manufacture, presence: true

    def attributes
      {
        :id => product.id,
        :name => product.name,
        :price => product.price,
        :released_on => product.released_on,
        :manufacter_name => manufacture.name
      }
    end

    def initialize(attributes = {})
      attributes.each { |name, value| send("#{name}=", value) }
    end

    def to_csv
      CSV::Row.new(attributes.keys, attributes.values)
    end

    def persisted?
      false
    end

    def attrs_valid?
      product.try(:valid?) && manufacture.try(:valid?)
    end

    def save!
      if valid?
        product.save!
        true
      else
        false
      end
    end

  end
end
