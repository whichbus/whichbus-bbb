define ['whichbus'], (WhichBus) ->
	class WhichBus.Models.Arrival extends Backbone.Model
		url: -> 
			# extract OTP part of stop ID because API returns OBA IDs
			stopId = /_?(\d+)$/.exec(@get('stopId'))[1]
			WhichBus.api + "stops/#{@get('agencyId')}/#{stopId}/arrivals"

		parse: (response, options) ->
			# get just the requested trip out of the arrivals array
			tripPattern = new RegExp("_#{@get('tripId')}$")
			_.find response, (item) -> tripPattern.test item.tripId

		isLoaded: -> @get('scheduledArrivalTime')?

		isPrediction: -> @get('predictedArrivalTime')?

		# return predicted time if available, or scheduled if fetch request finished
		arrivalTime: ->
			if @isPrediction() then WhichBus.format_time @get('predictedArrivalTime')
			else if @isLoaded() then WhichBus.format_time @get('scheduledArrivalTime')

		departureTime: ->
			if @isPrediction() then WhichBus.format_time @get('predictedDepartureTime')
			else if @isLoaded() then WhichBus.format_time @get('scheduledDepartureTime')
		# difference between scheduled and predicted in minutes or empty string
		deltaMinutes: ->
			predicted = @get('predictedArrivalTime')
			if predicted > 0
				# convert difference from scheduled time to minutes. [msec/min]
				Math.round((@get('scheduledArrivalTime') - predicted) / 60000)
			else ''
		# human-formatted prediction delta string
		readableDelta: ->
			delta = @deltaMinutes()
			if delta > 0 then "#{delta}m early"
			else if delta < 0 then "#{Math.abs(delta)}m late"
			else if delta is 0 then 'on time' else ''
			# minute#{if delta > 1 then 's' else ''} 
		# CSS class for delta string label 
		deltaClass: ->
			delta = @deltaMinutes()
			if delta is 0 then 'label-info'
			else if delta > 0 then 'label-success'
			else if delta < 0 then 'label-important'

	class WhichBus.Collections.Arrivals extends Backbone.Collection
		# Collection does not have the parse() filter that the Model has because we
		# expect it to hold all of them. Also has _.filter() mixed in.

		model: WhichBus.Models.Arrival

		url: -> WhichBus.api + "stops/#{@get('agencyId')}/#{@get('stopId')}/arrivals"

			