class AlbumClient < OpenStruct
  include Roar::JSON
  include AlbumRepresenter
  include Roar::Client
end
