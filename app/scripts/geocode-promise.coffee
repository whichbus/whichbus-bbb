define ->
	defaultLocation:
		name: 'Seattle'
		vicinity: 'Seattle, WA'
		position: new google.maps.LatLng(47.6097, -122.3331)

	initialize: (map) ->
		# initalize Places service using Google map object (tricky Google!)
		@places = new google.maps.places.PlacesService(map)

	###
	returns promise for user's current position if available, or default location if
	resolveDefault options is enabled. if resolveDefault=false then promise is rejected
	on geocode fail.
	###
	getCurrentPosition: (resolveDefault=true)->
		promise = new $.Deferred()
		# success callback resolves promise with user's position
		success = (position) ->
			lat = position.coords.latitude.toFixed(7)
			lng = position.coords.longitude.toFixed(7)
			promise.resolve
				name: 'Current Location'
				position: new google.maps.LatLng lat, lng
		# error callback resolves promise with default location or
		# rejects with error object if resolveDefault disabled.
		error = (error) => 
			console.error error.message
			if resolveDefault
				promise.resolve @defaultLocation
			else promise.reject error
		# make the call with the callbacks we just wrote
		navigator.geolocation.getCurrentPosition success, error
		# return promise object for chaining
		promise.promise()

	###
	performs the raw task of calling Google Places service for answers.
	returns a promise of the geocode request that receives results array
	on done and error code on fail.
	###
	geocode: (query, done, fail) ->
		# create promise for geocode() call, set callbacks if provided
		promise = new $.Deferred()
		promise.then(done, fail or done) if done?
		# begin by getting current position for Places query.
		# if user has disabled sharing this returns default location.
		@getCurrentPosition().done (result) =>
			console.log "PLACES query '#{query}' near #{result.position}"
			# perform a nearby Places search and resolve promise based on result
			@places.nearbySearch
				keyword: query
				location: result.position
				radius: 50000
			, (results, status) -> 
				if status == google.maps.GeocoderStatus.OK
					promise.resolve results
				else promise.reject(status, query)
		# return the promise for chaining
		promise.promise()

	###
	friendly wrapper for performing a geocode lookup. handles null check
	and unescaping. accepts the keyword 'here' for current location.
	otherwise fires geocode() request and returns first result from Google Places.
	accepts optional promise callbacks. if fail is omitted, done become always.
	###
	lookup: (query, done, fail) ->
		return console.error("LOOKUP FAIL: must provide query string") unless query?

		# if query is special keyword return current position promise
		if query is 'here' then return @getCurrentPosition().then(done, fail)

		# create promise for geocode() call, set callbacks if provided
		promise = new $.Deferred()
		promise.then(done, fail or done) if done?

		# if already latlng then convert to string and query for address
		if _.isObject query then query = query.toString()
		# unescape query string, ready to search!
		else query = unescape(query.replace(/\+/g, ' '))
		# query the geocoder! cascade reject to this promise on fail.
		@geocode(query).fail(promise.reject).done (results) =>
			# convert the results to desired format on success...
			console.log "GEOCODE RESULTS (#{results.length}):", results
			results = _.map results, (item) ->
				# trim zip code and country from formatted address
				name: item.name or (/^(.+)\d{5}/.exec(item.formatted_address)?[1] ? item.formatted_address)
				vicinity: item.vicinity
				position: item.geometry.location
			
			# TODO: disambiguation goes right here...
			# it should probably also be a promise.

			# but for now just pass along the first one.
			promise.resolve results[0]
		# and return the promise
		promise.promise()



