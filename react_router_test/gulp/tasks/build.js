var gulp        = require('gulp');
var runSequence = require('run-sequence');

// clean, webpackタスクを実行する
gulp.task('build', function(callback) {
  runSequence('clean', 'webpack', callback);
});
