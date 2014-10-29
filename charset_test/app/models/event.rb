

class Event < ActiveRecord::Base

  def self.import(file)
    content = file.read

    Rails.logger.debug "encoding: #{content.encoding}"
    Rails.logger.debug "Kconv.guess: #{Kconv.guess(content)}"
    Rails.logger.debug "NKF.guess: #{NKF.guess(content)}"

    # 変換されない
    #rows = CSV.parse(NKF.nkf('-xm0 -w', content))

    # 半角が全角に変更されてしまう
    # rows = CSV.parse(Kconv.toutf8(content))


    # CSV.foreach(file.path, headers: true, encoding: "CP932") do |row|
    #(1...rows.size).each do |i|
      # product = find_by_id rows[i][0]
      # product.title       = rows[i][1]
      # product.description = rows[i][2]
      # product.save!
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      str = "全角　ﾊﾝｶｸ 〜−¢£¬−‖"

      # endodeメソッドでCP932（Windows用のSJIS拡張）に変換
      #csv << str.encode("CP932")
      # => エラーが発生
      # Encoding::UndefinedConversionError: U+301C from UTF-8 to Windows-31J

      # endodeメソッドでCP932（Windows用のSJIS拡張）に変換
      a = str.encode("cp932", :invalid => :replace, :undef => :replace)
      csv << [a, a.encoding, Kconv.guess(a), NKF.guess(a)]
      # => エラーは発生しなくなるが、? で置き換えられる

      # endodeメソッドでCP932（Windows用のSJIS拡張）に変換（※ sjis_safeは下記参照）
      a = sjis_safe(str).encode("cp932", :invalid => :replace, :undef => :replace)
      csv << [a, a.encoding, Kconv.guess(a), NKF.guess(a)]

      a = sjis_safe(str).encode("Windows-31J", :invalid => :replace, :undef => :replace)
      csv << [a, a.encoding, Kconv.guess(a), NKF.guess(a)]

      # KconvでSJISに変換
      require 'kconv'
      a = str.kconv(Kconv::SJIS)
      csv << [a, a.encoding, Kconv.guess(a), NKF.guess(a)]

      # NKFでSJISに変換（-xm0: 半角、MIMEデコードをしない)
      a = NKF.nkf("-xm0 -s", str)
      csv << [a, a.encoding, Kconv.guess(a), NKF.guess(a)]

      # csv << column_names
      # all.each do |product|
      #   values = product.attributes.values_at(*column_names)

      #   # 返還前: イベント0ｲﾍﾞﾝﾄ 概要です0〜−¢£¬−‖

      #   # 変換後: エラー発生
      #   #         Encoding::UndefinedConversionError in XXXX
      #   #         U+301C from UTF-8 to Windows-31J
      #   #values = values.map { |v| v.to_s.encode("cp932", "utf-8") }

      #   # 変換後: イベント0ｲﾍﾞﾝﾄ 概要です0???????
      #   # 推定  : "encoding: Windows-31J","Kconv.guess: Shift_JIS"
      #   # values = values.map { |v| v.to_s.encode("cp932", "utf-8", :invalid => :replace, :undef => :replace) }

      #   # 変換後: イベント0ｲﾍﾞﾝﾄ 概要です0〜−¢£¬−‖
      #   # 推定  : "encoding: Windows-31J","Kconv.guess: Shift_JIS"
      #   # values = values.map { |v| sjis_safe(v.to_s).encode("cp932", "utf-8", :invalid => :replace, :undef => :replace) }

      #   # 変換後: イベント0イベント 概要です0〜−¢£¬−‖
      #   # 推定 : "encoding: Shift_JIS","Kconv.guess: Shift_JIS"
      #   # values = values.map { |v| v.to_s.kconv(Kconv::SJIS) }

      #   # 変換後: イベント0ｲﾍﾞﾝﾄ 概要です0〜−¢£¬−‖
      #   # 推定: "encoding: Shift_JIS","Kconv.guess: Shift_JIS"
      #   values = values.map { |v|   NKF.nkf('-xm0 -s', v.to_s) }

      #   # 変換後: イベント0ｲﾍﾞﾝﾄ","概要です0¢£¬
      #   # 推定: "encoding: Windows-31J","Kconv.guess: Shift_JIS"
      #   # values = values.map { |v|   NKF.nkf('-xm0 --ic=UTF-8 --oc=CP932 --cp932', v.to_s) }

      #   values.push "encoding: #{values[2].encoding}"
      #   values.push "Kconv.guess: #{Kconv.guess(values[2])}"
      #   values.push "NKF.guess: #{NKF.guess(values[2])}"
      #   csv << values
      # end
    end
  end

  def self.sjis_safe(str)
  [
    ["301C", "FF5E"], # wave-dash
    ["2212", "FF0D"], # full-width minus
    ["00A2", "FFE0"], # cent as currency
    ["00A3", "FFE1"], # lb(pound) as currency
    ["00AC", "FFE2"], # not in boolean algebra
    ["2014", "2015"], # hyphen
    ["2016", "2225"], # double vertical lines
  ].inject(str) do |s, (before, after)|
    s.gsub(
      before.to_i(16).chr('UTF-8'),
      after.to_i(16).chr('UTF-8'))
    end
  end

end
