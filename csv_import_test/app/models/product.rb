class Product < ActiveRecord::Base

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      # {カラム名 => 値, ...} のハッシュを作成する
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      product = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      product.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv'  then Roo::Csv.new(file.path,    nil, :ignore)
    when '.xls'  then Roo::Excel.new(file.path,  nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    when '.ods'  then Roo::OpenOffice.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "price", "released_on"]
  end
end
