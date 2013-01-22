define ['whichbus', 'models/itinerary', 'views/segment'], (WhichBus) ->
	class WhichBus.Views.Itinerary extends Backbone.View
		template: 'itinerary'

		className: ''

		# events:
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

		cleanup: ->