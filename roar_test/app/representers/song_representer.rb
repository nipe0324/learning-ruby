module SongRepresenter
  include Roar::JSON

  property :name
  property :length_sec
  # property :singer
  # property :album
  # property :singer_name

  # def singer_name
  #   singer.try(:name)
  # end
end
