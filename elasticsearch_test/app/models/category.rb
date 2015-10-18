class Category < ActiveRecord::Base
  has_many :restaurants

  validates :name, format: { without: Regexp.new("\\#{::Restaurant::DELIMITER}") }
end
