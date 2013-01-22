define ['whichbus'], (WhichBus) ->
	WhichBus.Views.Navbar = Backbone.View.extend
		template: 'navbar'

		className: ''

		events:
			'click a.popout': 'showPopout'

		initialize: ->
			# view setup

		serialize: -> 
			# @model.toJSON()

		beforeRender: ->
			# set and insert views

		afterRender: ->
			# after render, cache selectors

		showPopout: ->