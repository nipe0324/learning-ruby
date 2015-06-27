module Json
  class Tag < OpenStruct
    module Representer
      include Roar::JSON
      # JSON-API
      # include Roar::JSON::JSONAPI
      # type :tag

      property :id
      property :name
    end
  end
end
