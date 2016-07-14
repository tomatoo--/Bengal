gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

config = require './config'



gulp.task 'minify-js', ->
  gulp.src config.minifyJs.src
    .pipe $.uglify config.minifyJs.options
    .pipe gulp.dest config.minifyJs.dest
