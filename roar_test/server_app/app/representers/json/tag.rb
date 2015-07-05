module Json
  class Tag < OpenStruct
    module Representer
      include Roar::JSON

      property :id
      property :name
    end

    module Server
      include Roar::JSON
      include Representer
    end
  end
end
