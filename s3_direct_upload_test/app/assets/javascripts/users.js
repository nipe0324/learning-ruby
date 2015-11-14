$(function() {
  var fileInput = $('input[type="file"]');
  fileInput.on('change', function (e) {
    var file = e.target.files[0];

    // 0. 事前にファイルの大きさや種類をチェックする

    // 1. サーバからpolicyとsignatureをもらう
    // 上図でいう(1)に対応
    $.ajax({
      url: '/aws/policies',
      type: 'POST',
      dataType: 'json',
      data: {
        size: file.size,
        content_type: file.type,
        file_name: file.name
      }
    }).done(function (data) {
      // 2. サーバが返した情報をそのまま使ってFormDataを作る
      var name, fd = new FormData();
      for (name in data.form) if (data.form.hasOwnProperty(name)) {
        fd.append(name, data.form[name]);
      }
      fd.append('file', file); // ファイルも忘れずに添付する

      // 送信
     // 上図でいう(3)に対応
      var xhr = new XMLHttpRequest();
      xhr.open('POST', data.url, true);
      xhr.onreadystatechange = function (aEvt) {
        if (xhr.readyState == 4) {
          if (xhr.status == 201) {
            console.log('success');
            var location_url = $(xhr.responseText).find("location").text();
            var $img = $("<img src=" + location_url + " width='50px'>");
            var $hidden = $("<input type='hidden' name='user[avator_url]' value='" + location_url + "'/>");
            $("#avatar-image").append($img).append($hidden);
          } else {
            console.log('error');
            console.log(xhr.responseText);
          }
        }
      };
      xhr.send(fd);
    });
  });
});
