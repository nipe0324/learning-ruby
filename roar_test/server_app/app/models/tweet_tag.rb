class TweetTag < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :tag
end
