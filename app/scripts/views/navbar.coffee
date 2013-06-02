define ['whichbus', 'bootstrap/bootstrap-dropdown'], (WhichBus, PopoutView) ->
	WhichBus.Views.Navbar = Backbone.View.extend
		template: 'navbar'

		className: ''

		initialize: ->

		serialize: -> 
			fragment = Backbone.history.fragment
			if (idx = fragment?.indexOf('?')) >= 0 then fragment = fragment.substr(0, idx - 1)
			# show back button if fragment is not empty
			showBack: fragment isnt ''

		beforeRender: ->
			# set and insert views

		afterRender: ->
			$('.dropdown').dropdown()
