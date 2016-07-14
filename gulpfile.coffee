path = require 'path'
gulp = require 'gulp'
$ = do require 'gulp-load-plugins'
runSequence = require 'run-sequence'
del = require 'del'
browserSync = require('browser-sync').create()
_ = require 'lodash'


###*
 * Get the run-time parameters.
###
argv = require('minimist')(process.argv.slice(2))


###*
 * It defines a generic value that can be used throughout the app.
 * And flowed in a stream, it will be shared in the source files,
 * such as ".ejs".
###
appConfig = require './app.config'


###*
 * Extend the value for the specified target by env parameters.
###
if argv.dev
  _.assignIn appConfig, require './build/environments/development'
else if argv.stg
  _.assignIn appConfig, require './build/environments/staging'
else if argv.prod
  _.assignIn appConfig, require './build/environments/production'
else
  _.assignIn appConfig, require './build/environments/development'


###*
 * Setting for Development.
 * Enabling some of the features, or to disable.
###
setting = require './build/setting'


###*
 * Set the compression tasks.
###
minifyTasks = []
for key, val of setting.minify
  if val
    minifyTasks.push 'minify-' + key


###*
 * Configuration of each gulp-task.
###
config = require './build/tasks/config'


###*
 * Load all tasks.
###
require './build/tasks/load'


###*
 * Gulp task: watch
###
gulp.task 'watch', [], ->
  config.watch.isWatch = true

  $.watch config.watch.templates, ->
    gulp.start 'ejs'
  $.watch config.watch.scripts, ->
    gulp.start 'webpack'
  $.watch config.watch.stylesheets, ->
    gulp.start 'sass'
  $.watch config.watch.images, ->
    gulp.start 'images'
  # $.watch config.watch.assets, ->
  #   browserSync.reload()


###*
 * Gulp task: server
###
gulp.task 'server', ->
  if setting.ssi
    ssi = require 'browsersync-ssi'
    config.server.options.server.middleware.push ssi
      baseDir: path.join __dirname, config.server.options.server.baseDir
      ext: ".html"
  browserSync.init config.server.options



gulp.task 'default', ['setWebpackOptions'], (callback)->
  runSequence ['watch', 'server'], callback

gulp.task 'build', ['setWebpackOptions'], (callback)->
  runSequence ['ejs', 'webpack', 'sass'], callback

gulp.task 'release', (callback)->
  if minifyTasks.length > 0
    runSequence 'clean', 'copy', minifyTasks, callback
  else
    runSequence 'clean', 'copy', callback
