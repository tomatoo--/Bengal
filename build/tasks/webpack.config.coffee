webpack = require 'webpack'

module.exports =

  entry: {}

  output:
    filename: '[name].js'
    sourceMapFilename:'[file].map'

  devtool: 'source-map'

  resolve:
    extensions: ['', '.js', '.ts', '.coffee', '.jsx', '.webpack.js', '.web.js']
    modulesDirectories: ['node_modules']
    alias:
      'eventEmitter/EventEmitter': 'wolfy87-eventemitter'

  module:
    loaders: [
        test: /\.ts$/
        loader: 'ts'
      ,
        test: /\.coffee$/
        loader: 'coffee'
      ,
        test: /\.jsx$/
        loader: 'babel'
      ,
        test: /\.json$/
        loader: 'json'
    ]

  plugins: [
    new webpack.optimize.CommonsChunkPlugin 'app', 'app.js'
    new webpack.ProvidePlugin
      jQuery: 'jquery'
      $: 'jquery'
      jquery: 'jquery'
      _: 'lodash'
  ]
