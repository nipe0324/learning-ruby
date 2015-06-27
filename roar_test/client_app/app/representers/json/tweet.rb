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

      # ClientからServerへのリクエストを送るときの変換処理
      property :title, as: :content,  # Article.title => Tag.content 用にキー名を変換
               render_filter: -> (value, _doc, _args) { value.to_s[0, 10] + '...' } # Twitter用に文字列を短くする

      # Clientの作成メソッド(Collection用)
      def self.build_collection
        [].extend(::Json::Tweet::Client).extend(::Json::Tweet::Representer.for_collection)
      end

      # Clientの作成メソッド(Singular用)
      def self.build
        ::Json::Tweet.new.extend(::Json::Tweet::Client).extend(::Json::Tweet::Representer)
      end

      # APIのURL
      def api_url
        "http://localhost:3001/api/tweets"
      end

      # リモートのTweetsController#indexにアクセス
      def all
        get(uri: api_url, as: 'application/json')
      end

      # リモートのTweetsController#showにアクセス
      def show(id)
        get(uri: "#{api_url}/#{id}", as: 'application/json')
      end
    end
  end
end
