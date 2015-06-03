class Album < ActiveRecord::Base
  has_many :album_singers
  has_many :singers, through: :album_singers
  has_many :songs
end
