# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  belongs_to :post
end
