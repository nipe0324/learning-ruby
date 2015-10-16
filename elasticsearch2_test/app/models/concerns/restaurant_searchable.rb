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
    index_name "elasticsearch_test_#{Rails.env}"
    # タイプ名を指定(RDBでいうテーブル名)
    document_type "restaurant"

    # インデックス設定とマッピング(RDBでいうスキーマ)を設定
    # settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    settings do

      mappings dynamic: 'false' do # デフォルトでマッピングが自動作成されるがそれを無効にする

        # マッピングの参考
        # https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-core-types.html
        indexes :id, type: 'integer', index: 'not_analyzed'

        indexes :name, analyzer: 'kuromoji'
        indexes :name_kana, analyzer: 'kuromoji'
        indexes :alphabet
        indexes :property, analyzer: 'kuromoji'

        indexes :address, analyzer: 'kuromoji'
        indexes :description, analyzer: 'kuromoji'

        indexes :created_on, type: 'date', format: 'date_time'

        indexes :pref do
          indexes :name, analyzer: 'keyword', index: 'not_analyzed'
        end

        indexes :categories, analyzer: 'keyword', index: 'not_analyzed'
      end
    end

    # 検索する
    #
    # @param params [Hash] 検索のパラメータ
    #                        query: 検索クエリ
    #                        sort: ソートのキー 'id', 'created_on', ...
    #                        order: ソート順 'asc' or 'desc'
    #                        page: ページ番号
    # @return [Elasticsearch::Model::Response::Response]
    def my_search(params)
      setup_query(params[:query])
      setup_filter(params)
      setup_sort(params[:sort], params[:order])
      # setup_suggest(query) if query.present?
      Restaurant.__elasticsearch__.search(search_definition).page(params[:page]).results
    end

    def search_definition
      @search_definition ||= {
        query: {},

        highlight: {
          pre_tags: ['<em class="label label-highlight">'],
          post_tags: ['</em>'],
          fields: {
            name:    { number_of_fragments: 0 },
            property: { number_of_fragments: 0 },
            description:  { fragment_size: 50 },
            categories:  { fragment_size: 50 },
            address:  { fragment_size: 50 },
          }
        },

        filter: {},

        # aggregationの参考
        # https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations.html
        aggs: {
          categories: {
            terms: {
              field: 'categories'
            },
          },
          pref: {
            terms: {
              field: 'pref.name'
            },
          }
        }
      }
    end

    # クエリの参考:https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-queries.html
    def setup_query(query)
      if query.present?
        search_definition[:query] = {
          bool: {
            should: [
              {
                multi_match: {
                  query: query,
                  type: 'phrase',
                  fields: [
                    'name^2', 'name_kana^2', 'alphabet^2',
                    'property', 'address^4', 'description'
                  ]
                }
              }
            ]
          }
        }
      else
        search_definition[:query] = { match_all: {} }
      end
    end

    def setup_filter(params = {})
      # Prefill and set the filters (top-level `filter` and `facet_filter` elements)
      #
      # __set_filters = lambda do |key, f|

      #   search_definition[:filter][:and] ||= []
      #   search_definition[:filter][:and]  |= [f]

      #   # search_definition[:aggs][key.to_sym][:filter][:and] ||= []
      #   # search_definition[:aggs][key.to_sym][:filter][:and]  |= [f]
      # end

      if params[:categories]
        f = { term: { categories: params[:categories] } }
        search_definition[:filter][:and] ||= []
        search_definition[:filter][:and]  |= [f]

        search_definition[:aggs][:pref] = {
          filter: {
            term: {
              categories: params[:categories]
            }
          },
          aggs: {
            categories: {
              terms: {
                field: 'pref.name'
              }
            }
          }
        }
      end

      if params[:pref]
        f = { term: { 'pref.name' => params[:pref] } }
        search_definition[:filter][:and] ||= []
        search_definition[:filter][:and]  |= [f]

        search_definition[:aggs][:categories] = {
          filter: {
            term: {
              'pref.name' => params[:pref]
            }
          },
          aggs: {
            pref: {
              terms: {
                field: 'categories'
              }
            }
          }
        }
      end

      # if params[:published_week]
      #   f = {
      #     range: {
      #       published_on: {
      #         gte: params[:published_week],
      #         lte: "#{params[:published_week]}||+1w"
      #       }
      #     }
      #   }
      #   __set_filters.(:categories, f)
      #   __set_filters.(:authors, f)
      # end
    end

    # ソートパラメータを指定しない場合は、スコア(_score)の降順に
    # 並べられる(Elasticsearchのデフォルト)
    # ソートの参考: https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-sort.html
    def setup_sort(sort, order)
      unless sort =='relevancy'
        # 通常はフィールドをソートするときスコアは計算されないが、
        # track_scores = trueに設定し場合スコアは計算されトラックされる
        # search_definition[:track_scores] = true
        search_definition[:sort] = { sort => order }
      end
    end

    # def setup_suggest(query)
    #   search_definition[:suggest] = {
    #     text: query,
    #     suggest_title: {
    #       term: {
    #         field: 'title.tokenized',
    #         suggest_mode: 'always'
    #       }
    #     },
    #     suggest_body: {
    #       term: {
    #         field: 'content.tokenized',
    #         suggest_mode: 'always'
    #       }
    #     }
    #   }
    # end

    # Elasticsearchから返されるJSON形式にシリアライズされたデータをカスタマイズする
    def as_indexed_json(options={})
      hash = as_json(
        include: { pref: { only: [:name] } }
      )

      hash['categories'] = [
        category1.try(:name), category2.try(:name), category3.try(:name), category4.try(:name), category5.try(:name)
      ].compact
      hash
    end
  end
end
