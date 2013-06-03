define ['whichbus', 'geocode-promise', 'models/itinerary'], (WhichBus, Geocode) ->
	class WhichBus.Models.Plan extends Backbone.Model
		urlRoot: WhichBus.otp + 'plan'

		defaults:
			numItineraries: 3
			arriveBy: false
			modes: ['TRANSIT','WALK']
			optimize: 'QUICK'
			geocode: true
			maxWalkDistance: 1000

		defaultOptions:
			transferPenalty: 300
			maxTransfers: 1
			# reverseOptimizeOnTheFly: true
			showIntermediateStops: true

		itinerary: (index) -> @get('itineraries').models[index]

		clear: -> 
			# deletes itineraries from model so the view will render progress bar instead.
			# useful when updating plan options and fetching new itineraries.
			@set 'itineraries', undefined
			@

		# parse OTP response, return attributes to set on model
		parse: (response, options) ->
			plan = response.plan
			# turn each raw itinerary into Model and make a Collection out of them
			itineraries = new WhichBus.Collections.Itineraries _.map plan.itineraries, (item) ->
				new WhichBus.Models.Itinerary item
			# the model's attributes!
			date: new Date(plan.date)
			from: plan.from
			to: plan.to
			itineraries: itineraries

		# overloading sync so we can do some fanciness
		# TODO event parameters
		sync: (method, model, options) ->
			@trigger 'request'
			if method == 'read'
				finding = null
				if @get 'geocode'
					# first find from and to locations...
					finding = $.when Geocode.lookup(@get('from')), Geocode.lookup(@get('to'))
				else
					finding = $.when(@get('fromPlace'), @get('toPlace'))
				# if both succeed then perform the OTP request...
				finding.done (from, to) =>
					# store geocode results in *Place so OTP won't overwrite them.
					# use silent set to prevent immediate refresh.
					@set { fromPlace: from, toPlace: to, geocode: false }, silent: true
					xhr = $.getJSON @url(), @request(), (response) =>
						clearTimeout @time
						# OTP returns status 200 for everything, so handle response manually
						if response.error?
							@trigger 'error', @, response.error, options
						else
							@trigger 'sync', model, response, options
							options.success model, response
					@trigger 'request', model, xhr, options
					@time = setTimeout (=> @trigger('plan:timeout')), 7000
				# if either fail then trigger the error event and let views takeover...
				finding.fail (error, query) => 
					@trigger 'error', @, error, query
			else
				@trigger 'error', @, message: 'Plan is read-only'
				options.error 'Plan is read-only.'

		# create the request params from the models, needs some preprocessing
		request: -> $.extend {}, @defaultOptions,
			date: WhichBus.format_date(@get('date'))
			time: WhichBus.format_time_24(@get('date'))
			arriveBy: @get('arrive_by')
			mode: @get('modes').join()
			optimize: @get('optimize')
			fromPlace: @positionString @get('fromPlace').position
			toPlace: @positionString @get('toPlace').position
			numItineraries: @get('desired_itineraries')
			maxWalkDistance: @get('maxWalkDistance')

		# form nice lat,lng string regardless of position format (object or G.LatLng)
		positionString: (position) ->
			return '' unless position
			if _.isFunction position.lat
				"#{position.lat()},#{position.lng()}"
			else
				"#{position.lat},#{position.lng or position.lon}"
