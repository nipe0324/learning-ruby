var gulp          = require('gulp');
var webpack       = require('gulp-webpack');
var webpackConfig = require('./webpack.config.js');

// webpackを使ってjsファイルをコンパイルする
// TODO: 本番用の場合、digestや圧縮など実施する必要がある
gulp.task('webpack', function(callback) {
  gulp
    .src('')
    .pipe(webpack(webpackConfig))
    .pipe(gulp.dest(webpackConfig.output.publicPath));
});
