require 'roar/client'

module Json
  class Tweet < OpenStruct
    module Representer
      include Roar::JSON
      collection_representer class: ::Json::Tweet

      # JSON-API
      # include Roar::JSON::JSONAPI
      # type :tweet

      property :id
      property :content

      collection :tags, class: ::Json::Tag, extend: ::Json::Tag::Representer
    end

    module Client
      include Roar::JSON
      include Roar::Client
    end
  end
end
