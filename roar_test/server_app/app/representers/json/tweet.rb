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

      collection :tags, class: ::Tag, extend: ::Json::Tag::Server
    end

    module Client
      include Roar::JSON
      include Representer
      include Roar::Client

      # ClientからServerへのリクエストを送るときの変換処理
      property :title, as: :content,  # Article.title => Tweet.content 用にキー名を変換
               render_filter: -> (value, _doc, _args) { value.to_s[0, 10] + '...' } # Twitter用に文字列を短くする

      # ServerからClientへ受け取ったときの変換処理
      property :remote_tweet_id, as: :id,    # Tweet.id => Article.remote_tweet_id に変換
               skip_render: true

      # Clientの作成メソッド(Collection用)
      def self.build_collection
        [].extend(::Json::Tweet::Client).extend(::Json::Tweet::Client.for_collection)
      end

      # Clientの作成メソッド(Singular用)
      def self.build
        ::Json::Tweet.new.extend(::Json::Tweet::Client)
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
