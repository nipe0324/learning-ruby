require 'roar/client'

module Json
  class Tweet < OpenStruct
    module Representer
      include Roar::JSON
      collection_representer class: ::Json::Tweet

      property :id
      property :content

      collection :tags, class: ::Json::Tag, extend: ::Json::Tag::Representer
    end

    module Server
      include Roar::JSON
      include Representer

      collection :tags, class: ::Tag, extend: ::Json::Tag::Server,
                        parse_strategy: :find_or_instantiate
    end
  end
end
