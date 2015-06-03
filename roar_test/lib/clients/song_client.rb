class SongClient < OpenStruct
  include Roar::JSON
  include SongRepresenter
  include Roar::Client
end
