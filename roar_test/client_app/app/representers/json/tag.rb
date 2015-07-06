module Json
  class Tag < OpenStruct
    module Representer
      include Roar::JSON
      collection_representer class: ::Json::Tag

      property :id
      property :name
    end

    # only server side
    # module Server
    #   include Roar::JSON
    #   include Representer
    # end

    # only client side
    module Client
      include Roar::JSON
      include Representer
      include Roar::Client

      # Clientの作成メソッド(Collection用)
      def self.build_collection
        [].extend(::Json::Tag::Client).extend(::Json::Tag::Representer.for_collection)
      end

      # APIのURL
      def self.api_url
        "http://localhost:3001/api/tags"
      end

      # リモートのTagsController#indexにアクセス
      def all
        get(uri: ::Json::Tag::Client.api_url, as: 'application/json')
      end
    end
  end
end
