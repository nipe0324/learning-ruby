$(function() {
  $('.directUpload').find("input:file").each(function(i, elem) {
    var fileInput    = $(elem);
    var form         = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar  = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);

    fileInput.on('click', function(event) {
      // コントローラーからPresinge Postデータを取得
      $.ajax({
        type: 'GET',
        url: '/aws/s3_policy',
        dataType: 'json'
      }).done(function(response) {
        // S3にファイルアップロード
        fileInput.fileupload({
          fileInput:       fileInput,
          url:             response.url,
          type:            'POST',
          autoUpload:       true,
          formData:         response.data,
          paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
          dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
          replaceFileInput: false,
          progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            progressBar.css('width', progress + '%')
          },
          start: function (e) {
            submitButton.prop('disabled', true);

            progressBar.
              css('background', 'green').
              css('display', 'block').
              css('width', '0%').
              text("Loading...");
          },
          done: function(e, data) {
            submitButton.prop('disabled', false);
            progressBar.text("Uploading done");

            // extract key and generate URL from response
            var key   = $(data.jqXHR.responseXML).find("Key").text();
            var url   = '//' + response.host + '/' + key;

            // create hidden field
            var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url });
            // create image tag
            var image = $("<image src='" + url + "' width='80px'>");
            form.append(input).append(image);
          },
          fail: function(e, data) {
            submitButton.prop('disabled', false);

            progressBar.
              css("background", "red").
              text("Failed");
          }
        });
      });
    });

  });
});
