define ['whichbus', 'models/plan', 'views/itinerary', 'views/plan-error'], (WhichBus) ->
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
			@model.on 'change request', @render, @
			@model.on 'error',  @error, @
			# and get it loading. this will geocode from/to and hit OTP.
			# finally it'll trigger the change event and we can re-render.
			@model.fetch()
			# render the screen now to clear old plan
			@render()

		serialize: -> 
			# show loading bar if model does not contain itineraries
			to: @model.get('to')
			from: @model.get('from')
			fromPlace: @model.get('fromPlace')
			toPlace: @model.get('toPlace')
			loading: not @model.get('itineraries')?

		beforeRender: ->
			# move start and end markers to new locations now that the plan has loaded
			WhichBus.Map.moveMarker @start, @model.get('from'), true
			WhichBus.Map.moveMarker @end, @model.get('to'), true

			@errorView?.remove()
			@model.get('itineraries')?.each (item) =>
				@insertView '#itineraries', new WhichBus.Views.Itinerary(model: item)

		afterRender: ->
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

		error: (model, error, query) ->
			@errorView = new WhichBus.Views.PlanError
				model: @model
				error: error
				query: query
			@errorView.render()
			@setView '#itineraries', @errorView
