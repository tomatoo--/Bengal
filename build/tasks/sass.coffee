gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

config = require './config'



gulp.task 'sass', ->
  gulp.src config.sass.src
    .pipe $.plumber
      errorHandler: (err)->
        console.log(err.messageFormatted)
        this.emit('end')
    .pipe $.if config.watch.isWatch, ($.changed config.sass.dest, {extension: '.css'})
    .pipe $.sourcemaps.init()
    .pipe $.sass config.sass.options
    .pipe $.autoprefixer config.sass.autoprefixer.options
    .pipe $.sourcemaps.write('./')
    .pipe gulp.dest config.sass.dest
