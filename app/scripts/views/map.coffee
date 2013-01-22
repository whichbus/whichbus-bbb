define ['lodash', 'whichbus', 'geocode'], (_, WhichBus, Geocode) ->
	G = google.maps

	class WhichBus.Views.GoogleMap extends Backbone.View
		initialize: ->
			console.log 'CREATING MAP'
			mapOptions =
				center: new G.LatLng(47.62167, -122.349072)
				zoom: 13
				mapTypeId: G.MapTypeId.ROADMAP
				mapTypeControl: false
				streetViewControl: false
				zoomControl: true
				zoomControlOptions:
					style: G.ZoomControlStyle.DEFAULT
			@map = new G.Map(@el, mapOptions)
			Geocode.initialize @map

			@markerDefaults =
				clickable: false
				draggable: false
				# icon: # SOME ICON

		latlng: (param) ->
			# create as an array [lat, lon]
			if _.isArray param then new G.LatLng param[0], param[1]
			# or as a hash { lat:?, lon:? }
			else if _.isObject param then new G.LatLng param.lat, param.lon or param.lng
			# or as two parameters latlng(lat, lon)
			else new G.LatLng(arguments[0], arguments[1] ? arguments[0])

		# marker [true], 'marker', [x,y], [icon]
		# marker true, {}
		marker: (add, options, position, icon) ->
			# maybe we only get an options array...
			if arguments.length is 1
				options = arguments[0]
			# maybe they omit add and go the long way...
			else if _.isString add
				options =
					title: add
					position: @latlng options
					icon:  position
				add = false
			# maybe they omit add add go the long way
			else if _.isString options
				options =
					title: options
					position: @latlng position
					icon: icon
			# or they gave add and options
			marker = new G.Marker _.extend({}, @markerDefaults, options)
			# do not add marker to the map yet, that's what @addLayer is for.
			if add then @addLayer marker # ...unless asked.
			marker

		moveMarker: (marker, position) ->
			marker.setPosition @latlng position
			@

		polyline: (points, color = '#000', weight = 5, opacity = 0.6) ->
			points = G.geometry.encoding.decodePath(points)
			new G.Polyline
				path: points,
				strokeColor: color,
				strokeWeight: weight,
				strokeOpacity: opacity

		multiPolyline: (polylinesArray, color) ->
			# TODO: replace with _.map
			polylines = []
			for poly in polylinesArray
				polylines.push @create_polyline(poly, color)
			polylines

		# adds an item or array of items to the map
		addLayer: (mapLayer...) ->
			if _.isArray mapLayer
				item.setMap @map for item in mapLayer
			else
				mapLayer?.setMap @map
			@

		# removes an item or array of items from the map
		removeLayer: (mapLayer...) ->
			if _.isArray mapLayer
				item?.setMap null for item in mapLayer
			else
				mapLayer?.setMap null
			@

		# MAP EVENTS
		onMapEvent: (overlay, event, callback) ->
			G.event.addListener overlay, event, callback

		offMapEvent: (listener) ->
			G.event.removeListener listener
