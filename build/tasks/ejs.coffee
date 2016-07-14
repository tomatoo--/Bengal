path = require 'path'
gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

config = require './config'



gulp.task 'ejs', ->
  gulp.src config.ejs.src
    .pipe $.plumber()
    .pipe $.if config.watch.isWatch, ($.changed config.ejs.dest, {extension: '.html'})
    .pipe $.data (file)->
      filePath = path.relative path.dirname(file.path), file.base
      filePath = if filePath == '' then './' else filePath + '/'
      staticData = config.ejs.data
      staticData.filePath = filePath
      return staticData
    .pipe $.ejs config.ejs.options, config.ejs.setting
    .on 'error', $.util.log
    .pipe gulp.dest config.ejs.dest
