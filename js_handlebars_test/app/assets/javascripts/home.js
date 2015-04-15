(function() {
  $(document).ready(function() {

    // 初期処理
    var content  = { id: 1 };
    var source   = $("#content-template").html();
    var template = Handlebars.compile(source);
    var html     = template(content);
    $("#content").html(html);


    // イベント登録
    $(".js_change_omake").on("click", function() {
      showDialog();
    });

    // ダイアログ表示
    var showDialog = function() {
      $.get("/omakes.json", function(data) {

        var content  = { omakes: data };
        var source   = $("#dialog-template").html();
        var template = Handlebars.compile(source);
        var html     = template(content);

        var dialog = $("#dialog");

        dialog.html(html);

        dialog.dialog({
          open: function(event, ui) {

            // 開いたときの処理
            console.log("opend");
            $(".js_select_item").on("click", function(event) {
              var no = $(event.target).attr("no");
              var selectedData = data.filter(function(item, index) {
                if (item.id == no) return true;
              });
              selectItem(dialog, selectedData[0]);
            });
          }
        });

      });
    };

    // ダイアログのアイテムを選択
    var selectItem = function(dialog, data) {
      // 値を設定
      // $(".js_id").html(data.id);
      // $(".js_name").html(data.name);
      // $(".js_price").html(data.price);
      // $(".js_weight").html(data.weight);
      var source   = $("#content-template").html();
      var template = Handlebars.compile(source);
      var html     = template(data);
      $("#content").html(html);

      dialog.dialog("close");
    };

  });
})();
