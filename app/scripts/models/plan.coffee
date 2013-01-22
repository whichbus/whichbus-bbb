define ['whichbus', 'geocode', 'models/itinerary'], (WhichBus, Geocode) ->
	# Geocode.initialize(WhichBus.map.map)
	WhichBus.Models.Plan = Backbone.Model.extend
		urlRoot: WhichBus.otp + 'plan'
		# url: 'plan'

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

		parse: (plan) ->
			@set
				date: new Date(plan.date)
				from: plan.from
				to: plan.to
				itineraries: new WhichBus.Collections.Itineraries(plan.itineraries)

		resolveLocations: (callback) ->
			Geocode.lookup 
				query: @get('from'), 
				success: (result) =>
					@set 'from', result.position
					Geocode.lookup 
						query: @get('to'), 
						success: (result) =>
							@set 'to', result.position
							console.log "we did it!", @get('from'), @get('to')
							callback()
						
		sync: (method, model, options) ->
			if method == 'read'
				@resolveLocations =>
					$.get @url(), @request(), (response) =>
						clearTimeout @time
						# OTP returns status 200 for everything, so handle response manually
						if response.error?
							options.error response.error.msg
						else options.success response.plan
					@time = setTimeout (=> @trigger('plan:timeout')), 7000
			else options.error 'Plan is read-only.'

		request: -> $.extend {}, @defaultOptions,
			# date: Transit.format_otp_date(@get('date'))
			# time: Transit.format_otp_time(@get('date'))
			arriveBy: @get('arrive_by')
			mode: @get('modes').join()
			optimize: @get('optimize')
			fromPlace: @positionString @get('from')
			toPlace: @positionString @get('to')
			numItineraries: @get('desired_itineraries')

		positionString: (position) ->
			if _.isFunction position.lat
				"#{position.lat()},#{position.lng()}"
			else
				"#{position.lat},#{position.lng or position.lon}"
