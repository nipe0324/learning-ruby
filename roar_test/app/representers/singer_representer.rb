module SingerRepresenter
  include Roar::JSON

  property :name
  collection :songs, extend: SongRepresenter, class: Song
end
