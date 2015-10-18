module ApplicationHelper
  # 現在表示しているドキュメント数を表示
  #   params - paramsオブジェクト(:page 現在のページ数, :per 現在の表示件数)
  #   ※pageやperに文字列を指定されるとうまくいかないかもしれない
  def current_page(params:)
    (params.fetch(:page, 1).to_i - 1) * params.fetch(:per, 0).to_i
  end

  # ページ表示件数のリンクを返す
  #   per_pages    - ページの表示件数を配列で指定する。最初の値がデフォルト値になる。（例： [40, 80, 120])
  #   query_string - 検索のクエリストリング
  def per_page_links(per_pages: [], query_string:)
    # 入力チェック
    unless per_pages.is_a?(Array) && per_pages.size >= 1 && per_pages.all?{|n| n.is_a?(Integer)}
      raise 'per_pages: にはint型の1つ以上の配列を設定してください'
    end

    # 表示件数の初期値の設定
    current = query_string.fetch(:per, per_pages.first).to_i

    # リンクのHTMLを作成
    per_pages.map do |per_page|
      if current == per_page
        per_page
      else
        link_to(per_page, "?#{query_string.merge(per: per_page).to_query}")
      end
    end.join(' | ').html_safe
  end

  # ソートのリンクを返す
  #   query_string - 検索のクエリストリング
  def sort_links(query_string:)
    # 現在の値の設定
    current = { sort: query_string.fetch(:sort, ::Restaurant::SORTS.first[:sort]) }

    # リンクのHTMLを作成
    ::Restaurant::SORTS.map do |sort|
      if current == sort.except(:name) # 現在のソート順をリンクで表示させない
        sort[:name]
      else
        link_to(sort[:name], "?#{query_string.merge(sort: sort[:sort]).to_query}")
      end
    end.join(' | ').html_safe
  end

  # クエリストリングを作成
  # 表示件数やソート順などのリンクを押した時にqやclosedなどのパラメータは設定したままにする
  # pageは設定しないのでページは0ページ目ににクリアされる
  #   params - paramsオブジェクト
  def query_string(params)
    params.slice(:q, :closed, :per, :sort)
  end
end
