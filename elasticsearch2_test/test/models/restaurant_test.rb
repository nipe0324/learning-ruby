# == Schema Information
#
# Table name: restaurants
#
#  id                :integer          not null, primary key
#  name              :string
#  property          :string
#  alphabet          :string
#  name_kana         :string
#  pref_id           :integer
#  area_id           :integer
#  station_id1       :integer
#  station_time1     :integer
#  station_distance1 :integer
#  station_id2       :integer
#  station_time2     :integer
#  station_distance2 :integer
#  station_id3       :integer
#  station_time3     :integer
#  station_distance3 :integer
#  category_id1      :integer
#  category_id2      :integer
#  category_id3      :integer
#  category_id4      :integer
#  category_id5      :integer
#  zip               :string
#  address           :string
#  north_latitude    :float
#  east_longitude    :float
#  description       :text
#  purpose           :integer
#  open_morning      :integer
#  open_lunch        :integer
#  open_late         :integer
#  photo_count       :integer
#  special_count     :integer
#  menu_count        :integer
#  fan_count         :integer
#  access_count      :integer
#  created_on        :datetime
#  modified_on       :datetime
#  closed            :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
