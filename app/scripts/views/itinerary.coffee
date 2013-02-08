define ['whichbus', 'models/itinerary', 'views/segment'], (WhichBus) ->
	class WhichBus.Views.Itinerary extends Backbone.View
		template: 'itinerary'

		tagName: 'li'
		className: 'itinerary'

		events:
			'click header': 'toggle'

		initialize: ->

		serialize: -> @model.attributes

		beforeRender: ->
			# add a view for each segment. Views.Segment handles polylines and markers
			_.each @model.get('legs'), (leg) =>
				@insertView '.segments', new WhichBus.Views.Segment(model: leg)

		afterRender: ->

		# toggle expanded appearance of itinerary
		toggle: -> 
			@$('.segments').slideToggle('fast')
			@$el.toggleClass('active')
			# fit bounds when expanded
			if @$el.hasClass 'active'
				WhichBus.Map.map.fitBounds(@model.bounds())
