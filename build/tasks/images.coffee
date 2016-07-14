gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

config = require './config'



gulp.task 'images', ->
  gulp.src config.images.src
    .pipe $.if config.watch.isWatch, ( $.changed(config.images.dest) )
    .pipe gulp.dest config.images.dest
