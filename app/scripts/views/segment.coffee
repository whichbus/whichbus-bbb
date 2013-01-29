define ['whichbus', 'models/segment', 'views/realtime'], (WhichBus) ->
	class WhichBus.Views.Segment extends Backbone.View

		tagName: 'li'
		className: 'segment'

		initialize: ->
			# choose template based on segment mode of transportation.
			# create realtime view if this segment is a transit segment.
			if @model.mode in WhichBus.Constants.TransitTypes
				@template = 'partials/transit'
				@realtime = new WhichBus.Views.RealTime 
					stop: @model.from
					trip: @model.tripId
					scheduled: WhichBus.format_time @model.startTime
			else 
				@template = 'partials/walk'

		serialize: -> @model

		beforeRender: ->
			# create map elements
			@line = WhichBus.Map.polyline @model.legGeometry.points, WhichBus.Constants.SegmentColors[@model.mode]
			@marker = WhichBus.Map.marker true, @model.mode, @model.from, WhichBus.Constants.Markers.StopDot
			WhichBus.Map.addLayer @line

			if @realtime? then @setView '.timing', @realtime

		cleanup: ->
			# don't forget to remove the map elements when we're done!
			WhichBus.Map.removeLayer @line, @marker
