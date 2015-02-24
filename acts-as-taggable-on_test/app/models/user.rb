class User < ActiveRecord::Base
  acts_as_ordered_taggable_on :skills, :interests
end
