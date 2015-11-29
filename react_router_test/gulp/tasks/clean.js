var gulp          = require('gulp');
var del           = require('del');

// public/assetsを削除する
gulp.task('clean', function(callback) {
  return del('./public/assets');
});
