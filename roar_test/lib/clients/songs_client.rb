# TODO: get collection
class SongsClient < Array
  include Roar::JSON
  include SongRepresenter.for_collection
  include Roar::Client
end
