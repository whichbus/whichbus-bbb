define ['whichbus', 'models/plan', 'views/itinerary'], (WhichBus) ->
	class WhichBus.Views.Plan extends Backbone.View
		template: 'plan'

		initialize: ->
			# plan termini markers
			@start = WhichBus.Map.marker true, 
				title: 'Start'
				icon: WhichBus.Constants.Markers.Start
				draggable: true
			@end = WhichBus.Map.marker true, 
				title: 'End'
				icon: WhichBus.Constants.Markers.End
				draggable: true
			# drag events on markers, bind handlers to @ for closure
			_.bindAll @, 'dragStart', 'dragEnd'
			WhichBus.Map.onMapEvent @start, 'dragend', @dragStart
			WhichBus.Map.onMapEvent @end, 'dragend', @dragEnd

			# create a plan model
			@model = new WhichBus.Models.Plan
				from: @options.from
				to: @options.to
			# render when the plan's attributes change
			@model.on 'change', @render, @
			# and get it loading. this will geocode from/to and hit OTP.
			# finally it'll trigger the change event and we can re-render.
			@model.fetch()

		serialize: -> 
			loading: not @model.get('itineraries')?

		beforeRender: ->
			# move start and end markers to new locations now that the plan has loaded
			WhichBus.Map.moveMarker @start, @model.get('from')
			WhichBus.Map.moveMarker @end, @model.get('to')

			@model.get('itineraries')?.each (item) =>
				@insertView '#itineraries', new WhichBus.Views.Itinerary(model: item)

		afterRender: ->
			$('#title h3').html("#{@options.from} to #{@options.to}")
			# expand first itinerary
			@$('#itineraries header:first').click()

		dragStart: (mouse) -> 
			# Backbone.history.navigate "plan/#{mouse.latLng.coordStr()}/#{@model.get('to').coordStr()}"
			@dragPlan 'from', mouse.latLng.toHash()

		dragEnd:   (mouse) -> 
			# Backbone.history.navigate "plan/#{@model.get('from').coordStr()}/#{mouse.latLng.coordStr()}"
			@dragPlan 'to', mouse.latLng.toHash()

		dragPlan: (which, where) -> 
			# update from or to, clear itineraries, re-fetch
			@model.set which, where
			@model.set 'itineraries', null
			@model.fetch()
			# clearing the itineraries here causes them to disappear from the map
			# between plan loads.

		cleanup: ->
			WhichBus.Map.removeLayer @start, @end
