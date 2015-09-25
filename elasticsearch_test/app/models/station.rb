# == Schema Information
#
# Table name: stations
#
#  id         :integer          not null, primary key
#  pref_id    :integer
#  name       :string
#  name_kana  :string
#  property   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Station < ActiveRecord::Base
  has_many :restaurants
  belongs_to :pref
end
