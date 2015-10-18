module ApplicationHelper
  # 現在表示しているドキュメントのfrom値を表示
  # ※文字列を指定されるとうまくいかないかもしれない
  def current_document
    (params.fetch(:page, 1).to_i - 1) * params.fetch(:per, 0).to_i
  end

  # ページ表示件数のリンクを返す
  def per_page_links
    # 表示件数の初期値の設定
    current = query_string.fetch(:per, ::Restaurant::PER_PAGES.first).to_i

    # aタグの作成
    ::Restaurant::PER_PAGES.map do |per_page|
      if current == per_page
        per_page
      else
        link_to(per_page, "?#{query_string.merge(per: per_page).to_query}")
      end
    end.join(' | ').html_safe
  end

  # ソートのリンクを返す
  def sort_links
    # 現在の値の設定。例：{ sort: 'created_at+asc' }
    current = { sort: query_string.fetch(:sort, ::Restaurant::SORTS.first[:sort]) }

    # aタグの作成
    ::Restaurant::SORTS.map do |sort|
      if current == sort.except(:name)
        sort[:name]
      else
        link_to(sort[:name], "?#{query_string.merge(sort: sort[:sort]).to_query}")
      end
    end.join(' | ').html_safe
  end

  # アグリゲーションのカテゴリリンクを作成
  def category_aggs_link(name:, count: nil, all: false)
    aggs_link(key: 'category', name: name, count: count, all: all)
  end

  # アグリゲーションの都道府県リンクを作成
  def pref_aggs_link(name:, count: nil, all: false)
    aggs_link(key: 'pref', name: name, count: count, all: all)
  end

  # アグリゲーションのリンクを作成
  # リンクのパターン
  #   一覧のリンク    => params[key]を除いたリンクを作成
  #   一覧以外のリンク(現在選択されている)  => params[key]の値からカテゴリ名を削除
  #   一覧以外のリンク(現在選択されていない) => params[key]の値にカテゴリ名を追加
  # 引数
  #   name:  [String]  リンクのテキスト名
  #   count: [Integer] カテゴリのドキュメント数。リンクのテキスト名に追加されて表示される (オプション)
  #   all:   [Boolean] true: リンク、false: 一覧以外のリンク（オプション）
  def aggs_link(key:, name:, count: nil, all: false)
    # 表示するリンク名
    link_text = count ? "#{name}(#{count})" : name

    if all # 一覧のリンク
      params = query_string.except(key)
      url = params.empty? ? '/' : "?#{params.to_query}"
      link_to link_text, url
    else # 一覧以外のリンク
      currents = query_string[key].try(:split, Restaurant::DELIMITER) || [] # 現在選択されているカテゴリ名
      # 複数のカテゴリで結合できるように、現在選択されている場合はパラメータからカテゴリ名を削除、選択されていない場合はカテゴリ名を追加する
      if name.in?(currents) # 現在選択されているカテゴリ名
        aggs_names = currents - [name]
        params = aggs_names.empty? ? query_string.except(key) : query_string.merge(key => aggs_names.join(Restaurant::DELIMITER))
        url = params.empty? ? '/' : "?#{params.to_query}"
        link_to url do
          "<input type='checkbox' checked='checked'> #{link_text}".html_safe
        end
      else # 現在選択されていないカテゴリ名
        aggs_names = (currents + [name]).uniq
        params = query_string.merge(key => aggs_names.join(Restaurant::DELIMITER))
        url = "?#{params.to_query}"
        link_to url do
          "<input type='checkbox'> #{link_text}".html_safe
        end
      end
    end
  end

  # 各リンクで引き継ぐクエリストリングパラメータ
  # 表示件数やソート順などのリンクを押した時に`q`や`closed`などのパラメータは引き続き設定したままにするために使用
  # 下記で`:page`は設定しないので、リンクを押した時に、ページは0ページ目ににクリアされる
  def query_string
    params.slice(:q, :closed, :per, :sort, :category, :pref)
  end
end
