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

class Restaurant < ActiveRecord::Base
  has_many :ratings
  belongs_to :pref
  belongs_to :area
  belongs_to :station1,  class_name: Station,  foreign_key: :station_id1
  belongs_to :station2,  class_name: Station,  foreign_key: :station_id2
  belongs_to :station3,  class_name: Station,  foreign_key: :station_id3
  belongs_to :category1, class_name: Category, foreign_key: :category_id1
  belongs_to :category2, class_name: Category, foreign_key: :category_id2
  belongs_to :category3, class_name: Category, foreign_key: :category_id3
  belongs_to :category4, class_name: Category, foreign_key: :category_id4
  belongs_to :category5, class_name: Category, foreign_key: :category_id5

  include RestaurantSearchable
end
