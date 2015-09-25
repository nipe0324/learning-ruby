# == Schema Information
#
# Table name: rating_votes
#
#  id         :integer          not null, primary key
#  rating_id  :integer
#  user       :string
#  created_on :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RatingVote < ActiveRecord::Base
  belongs_to :rating
end
