gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

config = require './config'



gulp.task 'minify-images', ->
  gulp.src config.minifyImages.src
    .pipe $.imagemin config.minifyImages.options
    .pipe gulp.dest config.minifyImages.dest
