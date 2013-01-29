define ['whichbus', 'models/plan', 'views/itinerary'], (WhichBus) ->
	class WhichBus.Views.Plan extends Backbone.View
		template: 'plan'

		initialize: ->
			# plan termini markers
			@start = WhichBus.Map.marker
				title: 'Start'
				icon: WhichBus.Constants.Markers.Start
				draggable: true
				zIndex: 3
			@end = WhichBus.Map.marker
				title: 'End'
				icon: WhichBus.Constants.Markers.End
				draggable: true
				zIndex: 3
			# drag events on markers, bind handlers to @ for closure
			_.bindAll @, 'dragStart', 'dragEnd'
			WhichBus.Map.onMapEvent @start, 'dragend', @dragStart
			WhichBus.Map.onMapEvent @end, 'dragend', @dragEnd
			# now construct me a navigation plan!
			@reloadPlan @options.from, @options.to

		reloadPlan: (from, to) -> 
			# create a plan model
			@model = WhichBus.plan = new WhichBus.Models.Plan from: from, to: to
			# render when the plan's attributes change
			@model.on 'change', @render, @
			# and get it loading. this will geocode from/to and hit OTP.
			# finally it'll trigger the change event and we can re-render.
			@model.fetch()
			# render the screen now to clear old plan
			@render()

		serialize: -> 
			# show loading bar if model does not contain itineraries
			loading: not @model.get('itineraries')?

		beforeRender: ->
			# move start and end markers to new locations now that the plan has loaded
			WhichBus.Map.moveMarker @start, @model.get('from'), true
			WhichBus.Map.moveMarker @end, @model.get('to'), true

			@model.get('itineraries')?.each (item) =>
				@insertView '#itineraries', new WhichBus.Views.Itinerary(model: item)

		afterRender: ->
			$('#title h3').html("#{@options.from} to #{@options.to}")
			# expand first itinerary
			@$('#itineraries header:first').click()

		cleanup: ->
			WhichBus.Map.removeLayer @start, @end

		dragStart: (mouse) -> 
			# Backbone.history.navigate "plan/#{mouse.latLng.coordStr()}/#{@model.get('to').coordStr()}"
			@reloadPlan mouse.latLng, @end.getPosition()

		dragEnd:   (mouse) -> 
			# Backbone.history.navigate "plan/#{@model.get('from').coordStr()}/#{mouse.latLng.coordStr()}"
			@reloadPlan @start.getPosition(), mouse.latLng
