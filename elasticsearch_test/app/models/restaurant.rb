# == Schema Information
#
# Table name: restaurants
#
#  id           :integer          not null, primary key
#  name         :string
#  alphabet     :string
#  name_kana    :string
#  pref_id      :integer
#  category_id  :integer
#  zip          :string
#  address      :string
#  lat          :float
#  lon          :float
#  description  :text
#  access_count :integer
#  created_at   :datetime
#  updated_at   :datetime
#  closed       :boolean
#

class Restaurant < ActiveRecord::Base
  belongs_to :category
  belongs_to :pref

  # ページの表示件数
  PER_PAGES = [40, 80, 120]

  # ソートの組み合わせ
  # name: 画面に表示する文字列。sort: <ソートするキー名>+<ソート順序(asc or desc)>
  SORTS = [
    { name: '出店の新しい順', sort: 'created_at+desc' },
    { name: '出店の古い順',   sort: 'created_at+asc' },
    { name: 'あいうえお順',   sort: 'name_kana+asc' }
  ]

  # デリミタ: 複数カテゴリなどの検索条件に使用する
  DELIMITER = '+'

  # サジェストのキー
  SUGGEST_KEYS = %w( name_raw name_kana name_romaji name_hira )

  # デフォルトの１ページの表示件数
  paginates_per PER_PAGES.first

  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # インデックス再作成
  # Restaurant.__elasticsearch__.create_index! force: true
  # Restaurant.__elasticsearch__.refresh_index!
  # Restaurant.import

  index_name "restaurant_#{Rails.env}" # インデックス名を指定(RDBでいうデータベース)
  # document_type # ドキュメントタイプを指定(RDBでいうテーブル)。デフォルトでクラス名

  # インデックス設定とマッピング(RDBでいうスキーマ)を設定
  settings index: {
    analysis: {
      analyzer: {
        katakana_analyzer: {
          tokenizer: 'kuromoji_tokenizer',
          filter: ['katakana_readingform']
        }
      },
      filter: {
        katakana_readingform: {
          type: 'kuromoji_readingform',
          use_romaji: false
        }
      }
    }
  } do
    mappings dynamic: 'false' do # デフォルトでマッピングが自動作成されるがそれを無効にする
      # マッピングの公式ドキュメント
      # https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-core-types.html

      # indexesメソッドでインデックスする値を定義します。
      # analyzer: インデクシング時、検索時に使用するアナライザーを指定します。指定しない場合、グローバルで設定されているアナライザーが利用されます。
      # kuromojiは日本語のアナライザーです。
      indexes :name,      analyzer: 'kuromoji'
      indexes :name_kana, analyzer: 'kuromoji'
      indexes :alphabet

      indexes :zip
      indexes :address, analyzer: 'kuromoji'
      indexes :description, analyzer: 'kuromoji'

      # type: booleanでclosedはboolean型として定義します
      indexes :closed, type: 'boolean'

      indexes :access_count, type: 'integer'

      # date型として定義
      # formatは日付のフォーマットを指定(2015-10-16T19:26:03.679Z)
      # 詳細: https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-date-format.html
      indexes :created_at, type: 'date', format: 'date_time'
      indexes :updated_at, type: 'date', format: 'date_time'

      # ロケーション
      indexes :location, type: 'geo_point'

      # 階層化してインデクシングできます。pref.nameとして検索できます。
      indexes :pref do
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end

      indexes :category do
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end

      indexes :suggest do
        indexes :name_raw, type: 'completion'
        indexes :name_hira, type: 'completion'
        indexes :name_kana, type: 'completion', index_analyzer: 'katakana_analyzer'
        indexes :name_romaji, type: 'completion'
      end
    end
  end


  # Elasticsearchのクエリを作成し、検索を実施する
  # Elasticsearchからのレスポンスを返す
  def self.search(params = {})
    # 検索パラメータを取得
    keyword = params[:q]
    closed  = params[:closed].present?
    sort_by, order = (params[:sort] || SORTS.first[:sort]).split('+')
    category_names = params[:category].try(:split, Restaurant::DELIMITER) || []
    pref_names     = params[:pref].try(:split, Restaurant::DELIMITER) || []

    # 検索クエリを作成（Elasticsearch::DSLを利用）
    # 参考: https://github.com/elastic/elasticsearch-ruby/tree/master/elasticsearch-dsl
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        filtered {
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

          # 開店しているレストランのみ表示する条件(closed: false)
          # closed=trueの場合は、この検索条件を実施しない
          filter {
            term closed: 'false'
          } unless closed
        }
      }

      highlight {
        pre_tags ['<highlight>']
        post_tags ['</highlight>']
        fields %w{ name name_kana address pref.name category.name }
      }

      # ソート
      # @see https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-sort.html
      sort {
        by sort_by, order: order
      }

      # アグリゲーション - 集約をする
      # @see https://www.elastic.co/guide/en/elasticsearch/guide/current/aggregations.html
      aggregation :category do
        # categoryアグリゲーションのフィルタ条件
        condition = Elasticsearch::DSL::Search::Filters::Bool.new {
          if pref_names.present?
            pref_names.each { |pref_name|
              should { term 'pref.name' => pref_name }
            }
          else
            must { match_all }
          end
        }

        # アグリゲーションのフィルタを行う
        filter condition do
          aggregation :category do
            terms field: 'category.name', size: 10
          end
        end
      end

      aggregation :pref do
        # prefアグリゲーションのフィルタ条件
        condition = Elasticsearch::DSL::Search::Filters::Bool.new {
          if category_names.present?
            category_names.each { |category_name|
              should { term 'category.name' => category_name }
            }
          else
            must { match_all }
          end
        }

        # アグリゲーションのフィルタを行う
        filter condition do
          aggregation :pref do
            terms field: 'pref.name', size: 47
          end
        end
      end

      # Post Filter - 検索結果のみにフィルターをしたい場合に使う。アグリゲーションに対してフィルターされない
      # @see https://www.elastic.co/guide/en/elasticsearch/guide/current/_post_filter.html
      if category_names.present? || pref_names.present?
        post_filter {
          bool {
            # カテゴリのフィルタ
            must {
              bool {
                category_names.each { |category_name|
                  should { term 'category.name' => category_name }
                }
              }
            } if category_names.present?

            # 都道府県のフィルタ
            must {
              bool {
                pref_names.each { |pref_name|
                  should { term 'pref.name' => pref_name }
                }
              }
            } if pref_names.present?
          }
        }
      end
    }

    # 検索クエリをなげて結果を表示
    # __elasticsearch__にElasticsearchを操作するたくさんのメソッドが定義されている
    __elasticsearch__.search(search_definition)
  end

  # サジェスト結果を配列で返す
  # @see https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters.html
  def self.suggest(keyword)
    suggest_definition = SUGGEST_KEYS.inject({}) do |result, key|
      result.merge(
        key => {
          text: keyword,
          completion: { field: "suggest.#{key}", size: 10 }
        }
      )
    end

    response = Elasticsearch::Persistence.client.suggest({
      index: Restaurant.index_name,
      body: suggest_definition
    })

    # Elasticsearchからの結果を配列に変換する
    SUGGEST_KEYS.map do |key|
      response[key][0]['options'].map{|opt| opt.fetch('text', nil)}
    end.flatten.uniq
  end

  # インデクシング時に呼び出されるメソッド
  # マッピングのデータを返すようにする
  def as_indexed_json(options = {})
    attributes
      .symbolize_keys
      .slice(
        :name, :name_kana, :alphabet,
        :zip, :address, :closed, :description,
        :access_count,
        :created_at, :updated_at)
      .merge(pref: { name: pref.name })
      .merge(category: { name: category.name })
      .merge(location: location)
      .merge(suggest: {
        name_raw: name,
        name_hira: { input: name_kana, output: name },
        name_kana: name,
        name_romaji: { input: alphabet, output: name },
      })
  end

  def location
    (lat && lon) ? "#{lat},#{lon}" : nil
  end
end
