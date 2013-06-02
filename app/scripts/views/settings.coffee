define ['whichbus', 'geocode-promise'], (WhichBus, Geocode) ->
	class WhichBus.Views.Settings extends Backbone.View
		template: 'settings'

		className: 'about settings'

		events:
			'blur #default-location': 'updateDefault'

		initialize: ->
			@location = Geocode.defaultLocation

		status: (icon) ->
			@$('#status').attr 'class', "icon-#{icon}"

		beforeRender: ->
			# HACK to make this view appear fullscreen without changing the layout
			# see main.scss > .layout.splash
			$('#layout').addClass('splash')

		serialize: -> 
			defaultLocation: @location

		updateDefault: ->
			@status 'spinner icon-spin'
			promise = Geocode.lookup(@$('#default-location').val())
			promise.done (location) =>
				@status 'ok-sign success'
				@location = location
				@render()
				# console.log location
			promise.fail (error) =>
				@status 'remove-sign error'
				console.error error



