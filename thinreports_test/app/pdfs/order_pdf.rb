class OrderPDF

  # Classメソッドを定義
  def self.create order

    # Thin ReportsでPDFを作成
    report = ThinReports::Report.create do |r|

      # ThinReports Editorで作成したファイルを読み込む
      r.use_layout "#{Rails.root}/app/pdfs/order_pdf.tlf" do |config|
        # テーブルの[footer]部分の値を設定
        # イベントで設定する方法以外の方法が分からなかった
        config.list(:default) do
          events.on :footer_insert do |e|
            e.section.item(:label).value("合計")
            e.section.item(:total_price).value(order.total_price)
          end
        end
      end

      # 1ページ目を開始
      r.start_new_page

      # 注文番号と注文日の値を設定
      # itemメソッドでtlfファイルのIDを指定し、
      # valueメソッドで値を設定します
      r.page.item(:order_id).value(order.id)
      r.page.item(:purchased_at).value(order.purchased_at)

      # テーブルの値を設定
      # list に表のIDを設定する(デフォルトのID値: default)
      # add_row で列を追加できる
      # ブロック内のrow.valuesで値を設定する
      order.line_items.each do |item|
        r.list(:default).add_row do |row|
          row.values id:           item.id,
                     product_name: item.product_name,
                     price:        item.price,
                     quantity:     item.quantity,
                     total_price:  item.total_price
        end
      end
    end

    # ThinReports::Reportを返す
    return report
  end
end
