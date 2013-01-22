define ['whichbus', 'models/segment'], (WhichBus) ->
	class WhichBus.Views.Segment extends Backbone.View
		# TODO base template on mode

		tagName: 'li'
		className: 'segment'

		initialize: ->

		serialize: -> @model
			# TODO pretty up the templates

		beforeRender: ->
			@template = 'partials/' + @model.mode.toLowerCase()

			@line = WhichBus.Map.polyline @model.legGeometry.points, WhichBus.Constants.SegmentColors[@model.mode]
			@marker = WhichBus.Map.marker true, @model.mode, @model.from, WhichBus.Constants.Markers.StopDot

			WhichBus.Map.addLayer @line

		afterRender: ->

		cleanup: ->
			WhichBus.Map.removeLayer @line, @marker
