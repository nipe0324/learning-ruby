class Singer < ActiveRecord::Base
  has_many :songs
  has_many :album_singers
  has_many :albums, through: :album_singers
end
