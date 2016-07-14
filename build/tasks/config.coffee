path = require 'path'
appConfig = require '../../app.config'

argv = require('minimist')(process.argv.slice(2))

if !argv.s
  src = path.join 'src', 'pc'
else
  src = path.join 'src', 'sp'

srcCommon = path.join 'src', 'common'

dev = 'dev'
dist = 'dist'
doc_root = 'dev'

if argv.s
  dev = path.join dev, 'sp'
  dist = path.join dist, 'sp'


module.exports =

  ejs:
    src: src + '/templates/**/!(_)*.ejs'
    dest: dev
    data: appConfig
    options: {}
    setting: {
      ext: '.html'
    }


  sass:
    src: src + '/stylesheets/**/*.scss'
    dest:  dev + '/assets/css/'
    options:
      outputStyle: 'expanded'
      sourceComments: false
    autoprefixer:
      options:
        browsers: ['last 2 versions']


  webpack:
    src: src + '/scripts/'
    dest: dev + '/assets/js/'
    entry: src + '/scripts/**/!(_)*.+(js|ts|coffee|jsx)'


  images:
    src: src + '/images/**/*'
    dest: dev + '/assets/images'


  clean:
    dest: dist


  copy:
    src: [dev + '/**', '!' + dev + '/**/*.map', '!' + dev + '/**/*.ejs']
    dest: dist


  minifyHtml:
    src: dist + '/**/*.html'
    dest: dist
    options:
      collapseWhitespace: true
      minifyCSS: true
      minifyJS: true


  minifyCss:
    src: dist + '/**/*.css'
    dest: dist
    options:
      autoprefixer: false


  minifyJs:
    src: dist + '/**/*.js'
    dest: dist
    options:
      preserveComments: 'some'


  minifyImages:
    src: dist + '/**/*.+(jpg|jpeg|png|gif|svg)'
    dest: dist
    options:
      optimizationLevel: 7


  watch:
    templates:   '(' + src + '|' + srcCommon + ')/templates/**/*.+(ejs|jade)'
    scripts:     '(' + src + '|' + srcCommon + ')/scripts/**/*.+(js|ts|coffee|jsx)'
    stylesheets: '(' + src + '|' + srcCommon + ')/stylesheets/**/*.scss'
    images: src + '/images/**/*'
    assets: [dev + '/**/*.html', dev + '/**/*.js', dev + '/**/*.css']
    isWatch: false


  server:
    options:
      port: 3000
      server:
        baseDir: doc_root
        middleware: []
      ui:
        port: 3001
      ghostMode: false
