# == Schema Information
#
# Table name: prefs
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pref < ActiveRecord::Base
  has_many :restaurants
  has_many :areas
  has_many :stations
end
