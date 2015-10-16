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
  belongs_to :parent1, class_name: Category, foreign_key: :parent1
  belongs_to :parent2, class_name: Category, foreign_key: :parent2
end
