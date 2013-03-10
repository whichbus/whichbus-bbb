define ['whichbus'], (WhichBus) ->
	class WhichBus.Models.Itinerary extends Backbone.Model

		initialize: ->
			# convert duration from msec to seconds
			@set 'duration', @get('duration') / 1000

		leg: (index) -> @get('legs')[index]
		
		# plain-text summary of routes involved in trip
		summary: ->
			_.pluck(_.filter(@get('legs'), (leg) -> leg.mode not in ['WALK', 'BIKE']), 'route').join(', ')

		# HTML summary of routes involved in trip
		summaryHTML: ->
			index = 0
			stops = _.map(_.filter(@get('legs'), (leg) -> leg.mode not in ['WALK', 'BIKE']), (leg) -> 
				index++
				expandable = if index > 2 then ' expandable' else ''
				route = if leg.mode == 'FERRY' then 'FERRY' else leg.route
				"<span class='btn btn-route#{expandable}'>#{route}</span>"
			).join(' ')
			stops = "#{stops} <span class='btn btn-route expand'>+#{index-2}</span>" if index > 2
			return stops

		# nicely formatted trip timing string
		timing: ->
			start = WhichBus.format_time(@get('startTime'))
			end   = WhichBus.format_time(@get('endTime'))
			total = WhichBus.format_duration(@get('duration'))
			"#{start} (#{total})"

		# nicely formatted durations string
		duration: ->
			walk = WhichBus.format_duration(@get('walkTime'), true)
			wait = WhichBus.format_duration(@get('waitingTime'), true)
			bus =  WhichBus.format_duration(@get('transitTime'), true)
			"#{walk} walking, #{bus} transit"

		# create and cache bounds surrounding all points in leg geometry
		bounds: ->
			unless @get 'bounds'
				bounds = new google.maps.LatLngBounds()
				for leg in @get('legs')
					for point in google.maps.geometry.encoding.decodePath(leg.legGeometry.points)
						bounds.extend(point)
				@set 'bounds', bounds
			@get 'bounds'

	class WhichBus.Collections.Itineraries extends Backbone.Collection
		model: WhichBus.Models.Itinerary