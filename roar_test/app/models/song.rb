class Song < ActiveRecord::Base
  belongs_to :singer
  belongs_to :album
end
