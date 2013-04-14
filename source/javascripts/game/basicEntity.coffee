class App.BasicEntity
	constructor: (@params) ->
    @type = @params.type or 'basic'

  sync: ->