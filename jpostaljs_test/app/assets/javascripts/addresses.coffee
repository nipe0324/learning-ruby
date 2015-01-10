# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#address_zipcode").jpostal({
    # 郵便番号の入力欄が１つの場合
    # 111-1111と1111111のどちらの入力形式でも住所を自動入力してくれる
    postcode : [ "#address_zipcode" ],

    # 郵便番号の入力欄が3桁-4桁で分かれている場合
    # postcode : [ '#zipcode1', '#zipcode2' ]



    # 入力項目フォーマット
    #   %3  都道府県
    #   %4  市区町村
    #   %5  町域
    #   %6  大口事業所の番地
    #   %7  大口事業所の名称
    address  : {
                  "#address_prefecture_name" : "%3",
                  "#address_city"            : "%4%5",
                  "#address_street"          : "%6%7"
                }
  })
