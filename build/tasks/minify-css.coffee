gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

config = require './config'



gulp.task 'minify-css', ->
  gulp.src config.minifyCss.src
    .pipe $.cssnano config.minifyCss.options
    .pipe gulp.dest config.minifyCss.dest
