define ['whichbus', 'models/plan', 'views/itinerary'], (WhichBus) ->
	class WhichBus.Views.Plan extends Backbone.View
		template: 'plan'

		className: ''

		# events:
			# events!
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
			# WhichBus.Map.onMapEvent @start, 'dragend', @dragStart
			# WhichBus.Map.onMapEvent @end, 'dragend', @dragEnd
			# _.bindAll @, 'dragStart', 'dragEnd'

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
			# @model.toJSON()

		beforeRender: ->
			# console.log 'itineraries:', @itineraries
			# _.each @itineraries, (item) -> item.remove()
			# move start and end markers to new locations now that the plan has loaded
			WhichBus.Map.moveMarker @start, @model.get('from')
			WhichBus.Map.moveMarker @end, @model.get('to')

			@itineraries = []
			@model.get('itineraries')?.each (item) =>
				@insertView '#itineraries', new WhichBus.Views.Itinerary(model: item)
				# @itineraries.push itin

		afterRender: ->
			# after render, cache selectors
			@$('#title').html("#{@options.from} to #{@options.to}")

		dragPlanTimeout: ->
			clearTimeout @timeout if @timeout
			@timeout = setTimeout @dragPlan, 500

		# TODO: FIX DRAGGING! confusing type nonsense, method doesn't exist yadda yadda. SIMPIFY!
		dragPlan: ->
			@model.set
				from: @start.getPosition()
				to: @end.getPosition()
			@model.fetch()

		dragStart: (mouse) -> @model.set('from', mouse.latLng).fetch()
		dragEnd:   (mouse) -> @model.set('to', mouse.latLng).fetch()

		cleanup: ->
			WhichBus.Map.removeLayer @start, @end