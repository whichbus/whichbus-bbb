define ['whichbus', 'geocode', 'models/itinerary'], (WhichBus, Geocode) ->
	class WhichBus.Models.Plan extends Backbone.Model
		urlRoot: WhichBus.otp + 'plan'

		defaults:
			numItineraries: 3
			arriveBy: false
			modes: ['TRANSIT','WALK']
			optimize: 'QUICK'

		defaultOptions:
			maxWalkDistance: 1200
			transferPenalty: 300
			maxTransfers: 1
			# reverseOptimizeOnTheFly: true
			showIntermediateStops: true

		# parse OTP response, return attributes to set on model
		parse: (response, options) ->
			plan = response.plan
			date: new Date(plan.date)
			from: plan.from
			to: plan.to
			itineraries: new WhichBus.Collections.Itineraries(plan.itineraries)

		# geocode from and to locations before syncing
		resolveLocations: (callback) ->
			Geocode.lookup 
				query: @get('from'), 
				success: (result) =>
					@set 'from', result.position
					Geocode.lookup 
						query: @get('to'), 
						success: (result) =>
							@set 'to', result.position
							callback()
						
		# overloading sync so we can do some fanciness
		# TODO event parameters
		sync: (method, model, options) ->
			@trigger 'request'
			if method == 'read'
				# first find from and to locations
				@resolveLocations =>
					$.getJSON @url(), @request(), (response) =>
						clearTimeout @time
						# OTP returns status 200 for everything, so handle response manually
						if response.error?
							@trigger 'error'
							options.error response, response.error.msg
						else
							@trigger 'sync' 
							options.success model, response
					@time = setTimeout (=> @trigger('plan:timeout')), 7000
			else
				@trigger 'error' 
				options.error 'Plan is read-only.'

		# create the request params from the models, needs some preprocessing
		request: -> $.extend {}, @defaultOptions,
			# date: Transit.format_otp_date(@get('date'))
			# time: Transit.format_otp_time(@get('date'))
			arriveBy: @get('arrive_by')
			mode: @get('modes').join()
			optimize: @get('optimize')
			fromPlace: @positionString @get('from')
			toPlace: @positionString @get('to')
			numItineraries: @get('desired_itineraries')

		# form nice lat,lng string regardless of position format (object or G.LatLng)
		positionString: (position) ->
			if _.isFunction position.lat
				"#{position.lat()},#{position.lng()}"
			else
				"#{position.lat},#{position.lng or position.lon}"
