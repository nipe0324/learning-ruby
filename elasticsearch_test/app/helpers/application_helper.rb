module ApplicationHelper
  # 現在表示しているドキュメントのfrom値を表示
  # ※文字列を指定されるとうまくいかないかもしれない
  def current_document
    params.fetch(:page, 1).to_i * params.fetch(:per, 0).to_i
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

  # 各リンクで引き継ぐクエリストリングパラメータ
  # 表示件数やソート順などのリンクを押した時に`q`や`closed`などのパラメータは引き続き設定したままにするために使用
  # 下記で`:page`は設定しないので、リンクを押した時に、ページは0ページ目ににクリアされる
  def query_string
    params.slice(:q, :closed, :per)
  end
end
