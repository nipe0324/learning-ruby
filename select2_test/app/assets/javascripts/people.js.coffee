# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".searchable").select2({
      width:      200,  # 横幅
      allowClear: true  # x で選択したものを削除できる
      # 詳細は http://ivaynberg.github.io/select2/#documentation
    })
