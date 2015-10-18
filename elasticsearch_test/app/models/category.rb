class Category < ActiveRecord::Base
  has_many :restaurants

  # +を含んでいるカテゴリ名はinvalidとする（正規表現 /\/+/）
  validates :name, format: { without: Regexp.new("\\#{::Restaurant::DELIMITER}") }

end
