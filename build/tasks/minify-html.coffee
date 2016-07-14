gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

config = require './config'



gulp.task 'minify-html', ->
  gulp.src config.minifyHtml.src
    .pipe $.htmlmin config.minifyHtml.options
    .pipe gulp.dest config.minifyHtml.dest
