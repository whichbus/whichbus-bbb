define ['whichbus', 'models/segment'], (WhichBus) ->
	class WhichBus.Views.Segment extends Backbone.View

		tagName: 'li'
		className: 'segment'

		initialize: ->

		serialize: -> @model

		beforeRender: ->
			# choose template based on segment mode of transportation
			@template = 'partials/' + @model.mode.toLowerCase()
			# create map elements
			@line = WhichBus.Map.polyline @model.legGeometry.points, WhichBus.Constants.SegmentColors[@model.mode]
			@marker = WhichBus.Map.marker true, @model.mode, @model.from, WhichBus.Constants.Markers.StopDot
			WhichBus.Map.addLayer @line

		cleanup: ->
			# don't forget to remove the map elements when we're done!
			WhichBus.Map.removeLayer @line, @marker
