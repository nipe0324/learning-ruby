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

    module Client
      include Roar::JSON
      include Representer
      include Roar::Client

      # ClientからServerへのリクエストを送るときの変換処理
      property :title, as: :content,  # Article.title => Tag.content 用にキー名を変換
               render_filter: -> (value, _doc, _args) { value.to_s[0, 10] + '...' } # Twitter用に文字列を短くする

      # ServerからClientへ受け取ったときの変換処理
      property :remote_tweet_id, as: :id,    # Tweet.id => Article.remote_tweet_id に変換
               skip_render: true

      collection :tags, class: ::Json::Tag, extend: ::Json::Tag::Client

      # Clientの作成メソッド(Collection用)
      def self.build_collection
        [].extend(::Json::Tweet::Client).extend(::Json::Tweet::Representer.for_collection)
      end

      # Clientの作成メソッド(Singular用)
      def self.build
        ::Json::Tweet.new.extend(::Json::Tweet::Client)
      end

      # APIのURL
      def self.api_url
        "http://localhost:3001/api/tweets"
      end

      # リモートのTweetsController#indexにアクセス
      def all
        get(uri: ::Json::Tweet::Client.api_url, as: 'application/json')
      end

      # リモートのTweetsController#showにアクセス
      def show(id)
        get(uri: "#{::Json::Tweet::Client.api_url}/#{id}", as: 'application/json')
      end

      # リモートのTweetsController#createにアクセス
      def create
        post(uri: ::Json::Tweet::Client.api_url, as: 'application/json')
      end

      # リモートのTweetsController#updateにアクセス
      def update(id)
        put(uri: "#{::Json::Tweet::Client.api_url}/#{id}", as: 'application/json')
      end

      # リモートのTweetsController#destoryにアクセス
      def destroy(id)
        delete(uri: "#{::Json::Tweet::Client.api_url}/#{id}", as: 'application/json')
      end
    end
  end
end
