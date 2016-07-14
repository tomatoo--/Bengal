config = require '../../common/scripts/_config'

Module1 = require './modules/_Module1'

class App

  constructor: ->
    @init()

  init: ->
    console.log @

new App()
