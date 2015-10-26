# == Schema Information
#
# Table name: restaurants
#
#  id           :integer          not null, primary key
#  name         :string
#  alphabet     :string
#  name_kana    :string
#  pref_id      :integer
#  category_id  :integer
#  zip          :string
#  address      :string
#  lat          :float
#  lon          :float
#  description  :text
#  access_count :integer
#  created_at   :datetime
#  updated_at   :datetime
#  closed       :boolean
#

require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
