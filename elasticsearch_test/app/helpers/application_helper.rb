module ApplicationHelper
  # 現在表示しているドキュメント数を表示
  #   params - paramsオブジェクト(:page 現在のページ数, :per 現在の表示件数)
  #   ※文字列を指定されるとうまくいかないかもしれない
  def current_page(params: params)
    (params.fetch(:page, 1).to_i - 1) * params.fetch(:per, 0).to_i
  end

  # ページ表示件数のリンクを返す
  #   per_pages - ページの表示件数を配列で指定する。最初の値がデフォルト値になる。（例： [40, 80, 120])
  #   params    - paramsオブジェクト(:per 現在の表示件数、:q 検索キーワード、:closed 閉店しているレストランも含める)
  def per_page_links(per_pages: [], params: {})
    # 入力チェック
    unless per_pages.is_a?(Array) && per_pages.size >= 1 && per_pages.all?{|n| n.is_a?(Integer)}
      raise 'per_pages: にはint型の1つ以上の配列を設定してください'
    end

    # 表示件数の初期値の設定
    current = params.fetch(:per, per_pages.first).to_i

    # リンクのHTMLを作成
    per_pages.map do |per_page|
      if current == per_page
        per_page
      else
        # 表示件数のリンクを押した時にqとclosedパラメータは設定したままにする。
        # pageは設定しないのでページは0にクリアされる
        query_string = params.slice(:q, :closed).merge(per: per_page)
        link_to(per_page, "?#{query_string.to_query}")
      end
    end.join(' | ').html_safe
  end
end
