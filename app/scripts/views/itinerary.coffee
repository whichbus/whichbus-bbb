define ['whichbus', 'models/itinerary', 'views/segment'], (WhichBus) ->
	class WhichBus.Views.Itinerary extends Backbone.View
		template: 'itinerary'

		tagName: 'li'
		className: 'itinerary'

		events:
			'click header': 'toggle'
			# events!

		initialize: ->

		serialize: -> 
			summary: @model.summaryHTML()
			timing: @model.timing()
			duration: @model.duration()
			# index:

		beforeRender: ->
			# draw polylines
			_.each @model.get('legs'), (leg) =>
				@insertView '.segments', new WhichBus.Views.Segment(model: leg)

		afterRender: ->

		toggle: -> 
			@$('.segments').slideToggle('fast')
			@$el.toggleClass('active')
			if @$el.hasClass 'active'
				WhichBus.Map.map.fitBounds(@model.bounds())


		cleanup: ->
			# _.each @views, (item) -> item.cleanup()