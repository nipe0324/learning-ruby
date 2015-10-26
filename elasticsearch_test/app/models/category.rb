# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  name_kana  :string
#  parent1    :integer
#  parent2    :integer
#  similar    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :restaurants

  validates :name, format: { without: Regexp.new("\\#{::Restaurant::DELIMITER}") }
end
