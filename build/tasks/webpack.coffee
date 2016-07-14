path = require 'path'
through = require 'through2'
gulp = require 'gulp'
$ = do require 'gulp-load-plugins'
webpack = require 'webpack'
webpackStream = require 'webpack-stream'

config = require './config'
webpackConfig = require './webpack.config'



gulp.task 'webpack', ->
  gulp.src config.webpack.src
    .pipe $.plumber()
    .pipe webpackStream webpackConfig
    .pipe gulp.dest config.webpack.dest


###*
 * Set webpack options automatically.
###
gulp.task 'setWebpackOptions', ->

  ###*
   * Add the appConfig as DefinePlugin.
   * ※ Ignore the key with "_" prefix.
  ###
  _appConfig = require '../../app.config'
  appConfig = {}
  for key, val of _appConfig
    if key.substr(0, 1) != '_'
      appConfig[key] = val

  webpackConfig.plugins.push new webpack.DefinePlugin
    APP_CONFIG: JSON.stringify appConfig

  ###*
   * Set webpack-entry-options automatically.
   * Output while maintaining the hierarchical structure of the script directory.
   * ※ Ignore the file with "_" prefix.
  ###
  gulp.src config.webpack.entry
    .pipe through.obj (file, charset, callback)->
      webpackConfig.entry = webpackConfig.entry || {}
      fileName = file.path.replace(file.base, '')
        .replace(/\.(js|ts|coffee|jsx)$/, '')
      webpackConfig.entry[fileName] = file.path
      this.push file
      callback()
