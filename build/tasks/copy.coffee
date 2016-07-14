path = require 'path'
gulp = require 'gulp'

config = require './config'



gulp.task 'copy', ->
  gulp.src config.copy.src
    .pipe gulp.dest config.copy.dest
