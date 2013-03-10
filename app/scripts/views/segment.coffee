define ['whichbus', 'models/segment', 'views/realtime'], (WhichBus) ->
	class WhichBus.Views.Segment extends Backbone.View

		tagName: 'li'
		className: 'segment'

		initialize: ->
			# convert duration from msec to seconds
			@model.duration /= 1000
			# choose template based on segment mode of transportation.
			# create realtime view if this segment is a transit segment.
			if @model.mode in WhichBus.Constants.TransitTypes
				@template = 'partials/transit'
				@realtime = new WhichBus.Views.RealTime 
					stop: @model.from
					trip: @model.tripId
					scheduled: @model.startTime
			else 
				@template = 'partials/walk'

		serialize: -> @model

		beforeRender: ->
			# create map elements
			@marker = WhichBus.Map.marker true, @model.mode, @model.from, WhichBus.Constants.Markers.StopDot
			@line = WhichBus.Map.polyline @model.legGeometry.points, WhichBus.Constants.SegmentColors[@model.mode]
			WhichBus.Map.addLayer @line

			if @realtime? then @setView '.timing', @realtime

		cleanup: ->
			# don't forget to remove the map elements when we're done!
			WhichBus.Map.removeLayer @line, @marker
