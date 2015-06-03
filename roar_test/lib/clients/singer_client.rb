class SingerClient < OpenStruct
  include Roar::JSON
  include SingerRepresenter
  include Roar::Client
end
