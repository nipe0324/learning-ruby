# == Schema Information
#
# Table name: ratings
#
#  id               :integer          not null, primary key
#  restaurant_id    :integer
#  user_id          :integer
#  total            :integer
#  food             :integer
#  service          :integer
#  atmosphere       :integer
#  cost_performance :integer
#  title            :string
#  body             :text
#  purpose          :integer
#  created_on       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Rating < ActiveRecord::Base
  belongs_to :restaurant
  has_many :raging_votes
end
