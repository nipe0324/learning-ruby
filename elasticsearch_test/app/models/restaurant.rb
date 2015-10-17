class Restaurant < ActiveRecord::Base
  belongs_to :category
  belongs_to :pref

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "restaurant_#{Rails.env}" # インデックス名を指定(RDBでいうデータベース)
  # document_type # ドキュメントタイプを指定(RDBでいうテーブル)。デフォルトでクラス名

  # インデックス設定とマッピング(RDBでいうスキーマ)を設定
  settings do
    mappings dynamic: 'false' do # デフォルトでマッピングが自動作成されるがそれを無効にする
      # マッピングの公式ドキュメント
      # https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-core-types.html

      # indexesメソッドでインデックスする値を定義します。
      # analyzer: インデクシング時、検索時に使用するアナライザーを指定します。指定しない場合、グローバルで設定されているアナライザーが利用されます。
      # kuromojiは日本語のアナライザーです。
      indexes :name,      analyzer: 'kuromoji'
      indexes :name_kana, analyzer: 'kuromoji'

      indexes :zip # TODO: 必要?デフォルトってなに?
      indexes :address, analyzer: 'kuromoji'

      # type: でデータ型を指定します。デフォルトはstring型です。TODOほんと?
      indexes :closed, type: 'boolean'

      # date型として定義
      # formatは日付のフォーマットを指定(2015-10-16T19:26:03.679Z)
      # 詳細: https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-date-format.html
      indexes :created_at, type: 'date', format: 'date_time'

      indexes :pref do
        # TODO: keywordアナライザーは?
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end

      indexes :category do
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end
    end
  end

  # Elasticsearchのクエリを作成し、検索を実施する
  # Elasticsearchからのレスポンスを返す
  def self.search(params = {})
    # 検索パラメータを取得
    keyword = params[:q]

    # 検索クエリを作成（Elasticsearch::DSLを利用）
    # 参考: https://github.com/elastic/elasticsearch-ruby/tree/master/elasticsearch-dsl
    #
    # 検索キーワードが入力されたときは、下記クエリを作成
    # "query": {
    #   "multi_match": {
    #     "query":    "牛角", // 検索キーワード
    #     "fields": ["name", "name_kana", "address", "pref.name", "category.name"]
    #   }
    # }
    #
    # 検索キーワードが入力されてない時は、下記クエリを作成（すべてのドキュメントを取得）
    # "query": {
    #   "match_all": {}
    # }
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        if keyword.present?
          multi_match {
            query keyword
            fields %w{ name name_kana address pref.name category.name }
          }
        else
          match_all
        end
      }
    }

    # 検索クエリをなげて結果を表示
    # __elasticsearch__にElasticsearchを操作するたくさんのメソッドが定義されている
    __elasticsearch__.search(search_definition)
  end

  # インデクシング時に呼び出されるメソッド
  # マッピングのデータを返すようにする
  def as_indexed_json(options = {})
    attributes
      .symbolize_keys
      .slice(:name, :name_kana, :zip, :address, :closed, :created_at)
      .merge(pref: { name: pref.name })
      .merge(category: { name: category.name })
  end
end
