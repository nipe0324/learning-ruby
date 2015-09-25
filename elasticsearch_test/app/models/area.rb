# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  pref_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ActiveRecord::Base
  has_many :restaurants
  belongs_to :pref
end
