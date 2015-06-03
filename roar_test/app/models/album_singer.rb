class AlbumSinger < ActiveRecord::Base
  belongs_to :album
  belongs_to :singer
end
