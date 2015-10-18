# Restaurant.__elasticsearch__.create_index! force: true
# Restaurant.__elasticsearch__.refresh_index!
# Restaurant.import
class Restaurant < ActiveRecord::Base
  paginates_per 40

  belongs_to :category
  belongs_to :pref

  # ソートの組み合わせ
  # name: 画面に表示する文字列。sort: <ソートするキー名>+<ソート順序(asc or desc)>
  SORTS = [
    { name: '出店の新しい順', sort: 'created_at+desc' },
    { name: '出店の古い順',   sort: 'created_at+asc' },
    { name: 'あいうえお順',   sort: 'name_kana+asc' }
  ]

  # デリミタ: 複数カテゴリなどの検索条件に使用する
  DELIMITER = '+'

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
    closed  = params[:closed].present?
    sort_by, order = (params[:sort] || SORTS.first[:sort]).split('+')
    category_names = params[:category].try(:split, Restaurant::DELIMITER) || []
    pref_names     = params[:pref].try(:split, Restaurant::DELIMITER) || []

    # 検索クエリを作成（Elasticsearch::DSLを利用）
    # 参考: https://github.com/elastic/elasticsearch-ruby/tree/master/elasticsearch-dsl
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        filtered {
          # 全文検索
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

          # Filter - 検索結果とアグリゲーションの両方の検索条件
          # closed (閉店しているか否か)
          filter {
            term closed: 'false'
          } unless closed
        }
      }

      # ソート
      sort {
        by sort_by, order: order
      }

      # アグリゲーション
      # @see https://www.elastic.co/guide/en/elasticsearch/guide/current/aggregations.html
      aggregation :category do
        condition = Elasticsearch::DSL::Search::Filters::Bool.new {
          must { match_all }
          pref_names.each { |pref_name|
            should { term 'pref.name' => pref_name }
          }
        }

        filter condition do
          aggregation :category do
            terms field: 'category.name', size: 10
          end
        end
      end

      aggregation :pref do
        condition = Elasticsearch::DSL::Search::Filters::Bool.new {
          must { match_all }
          category_names.each { |category_name|
            should { term 'category.name' => category_name }
          }
        }

        filter condition do
          aggregation :pref do
            terms field: 'pref.name', size: 47
          end
        end
      end

      # Post Filter - 検索結果のみにフィルターをしたい場合に使う。アグリゲーションに対してフィルターされない
      # @see https://www.elastic.co/guide/en/elasticsearch/guide/current/_post_filter.html
      post_filter {
        bool {
          if [category_names, pref_names].all? {|var| var.blank?}
            must { match_all }
          else
            must {
              bool {
                category_names.each { |category_name|
                  should { term 'category.name' => category_name }
                }
              }
            } if category_names.present?

            must {
              bool {
                pref_names.each { |pref_name|
                  should { term 'pref.name' => pref_name }
                }
              }
            } if pref_names.present?
          end
        }
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
