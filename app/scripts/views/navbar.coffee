define ['whichbus', 'views/popout', 'bootstrap/bootstrap-dropdown'], (WhichBus, PopoutView) ->
	WhichBus.Views.Navbar = Backbone.View.extend
		template: 'navbar'

		className: ''

		initialize: ->

		serialize: -> 
			# @model.toJSON()

		beforeRender: ->
			# set and insert views

		afterRender: ->
			$('.dropdown').dropdown()
