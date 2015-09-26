module RestaurantSearchable
  extend ActiveSupport::Concern

  included do
    # Elasticsearchを簡単に使う多くのメソッドを追加
    include Elasticsearch::Model
    # 自動的にElasticsearchのドキュメントを更新してくれるコールバックを追加
    # ※ ドキュメントの更新数が多くなった場合に、ElasticsearchがボトルネックになりRailsが遅くなってしまう
    #   可能性があるので本番で使用するのはあまりよくなさそう。対応方法は別途記載
    include Elasticsearch::Model::Callbacks

    # インデックス名を指定(RDBでいうデータベース)
    index_name "elasticsarch_test-#{Rails.env}"
    # タイプ名を指定(RDBでいうテーブル名)
    document_type "restaurant"

    # インデックス設定とマッピング(RDBでいうスキーマ)を設定
    # settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    settings do
      mappings dynamic: 'false' do # デフォルトでマッピングが自動作成されるがそれを無効にする

        # 参考: https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-core-types.html

        indexes :id, index: 'not_analyzed'
        indexes :created_at, type: 'date', store: true, index: 'not_analyzed'
        indexes :updated_at, type: 'date', store: true, index: 'not_analyzed'

        indexes :name
        indexes :name_kana
        indexes :property

        indexes :pref do
          indexes :name, analyzer: 'keyword', index: 'not_analyzed'
        end

        indexes :category1 do
          indexes :name, analyzer: 'keyword', index: 'not_analyzed'
        end
      end
    end

    # 検索する
    #
    # @param query [String] 検索するフリーテキスト
    # @return [Elasticsearch::Model::Response::Response]
    def self.search(query, options = {})
      self.setup_query(query)
      # self.setup_filter(options)
      self.setup_sort(options)
      # setup_suggest(query) if query.present?
      __elasticsearch__.search(search_definition)
    end

    def self.setup_query(query)
      if query.present?
        search_definition[:query] = {
          bool: {
            should: [
              {
                multi_match: {
                  query: query,
                  type: 'phrase',
                  fields: ['name', 'name_kana']
                }
              }
            ]
          }
        }
      else
        search_definition[:query] = { match_all: {} }
      end
    end

    def setup_filter(options = {})
      if options[:category]
        f = { term: { categories: options[:category] } }

        __set_filters.(:authors, f)
        __set_filters.(:published, f)
      end

      if options[:author]
        f = { term: { 'authors.full_name.raw' => options[:author] } }

        __set_filters.(:categories, f)
        __set_filters.(:published, f)
      end

      if options[:published_week]
        f = {
          range: {
            published_on: {
              gte: options[:published_week],
              lte: "#{options[:published_week]}||+1w"
            }
          }
        }

        __set_filters.(:categories, f)
        __set_filters.(:authors, f)
      end
    end

    def self.setup_sort(options = {})
      # "sort": { "balance": { "order": "desc" } }
      # search_definition[:sort] = { options[:sort] => 'desc' }
      # search_definition[:track_scores] = true
    end

    def setup_suggest(query)
      search_definition[:suggest] = {
        text: query,
        suggest_title: {
          term: {
            field: 'title.tokenized',
            suggest_mode: 'always'
          }
        },
        suggest_body: {
          term: {
            field: 'content.tokenized',
            suggest_mode: 'always'
          }
        }
      }
    end

    def self.search_definition
      @search_definition ||= {
        query: {},

        size: 100

        # highlight: {
        #   pre_tags: ['<em class="label label-highlight">'],
        #   post_tags: ['</em>'],
        #   fields: {
        #     title:    { number_of_fragments: 0 },
        #     abstract: { number_of_fragments: 0 },
        #     content:  { fragment_size: 50 }
        #   }
        # },

        # filter: {},

        # facets: {
        #   categories: {
        #     terms: {
        #       field: 'categories'
        #     },
        #     facet_filter: {}
        #   },
        #   authors: {
        #     terms: {
        #       field: 'authors.full_name.raw'
        #     },
        #     facet_filter: {}
        #   },
        #   published: {
        #     date_histogram: {
        #       field: 'published_on',
        #       interval: 'week'
        #     },
        #     facet_filter: {}
        #   }
        # }
      }
    end

    def filter
      @filter ||= lambda do |key, f|
        @search_definition[:filter][:and] ||= []
        @search_definition[:filter][:and]  |= [f]

        @search_definition[:facets][key.to_sym][:facet_filter][:and] ||= []
        @search_definition[:facets][key.to_sym][:facet_filter][:and]  |= [f]
      end
    end

    # # Elasticsearchから返されるJSON形式にシリアライズされたデータをカスタマイズする
    # def as_indexed_json(options={})
    #   hash = self.as_json(
    #     include: { authors:    { methods: [:full_name], only: [:full_name] },
    #                comments:   { only: [:body, :stars, :pick, :user, :user_location] }
    #              })
    #   hash['categories'] = self.categories.map(&:title)
    #   hash
    # end
  end
end
