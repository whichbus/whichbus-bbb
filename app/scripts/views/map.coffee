define ['lodash', 'whichbus', 'geocode'], (_, WhichBus, Geocode) ->
	G = google.maps

	# convenience methods for translating G.LatLng into other useful types
	G.LatLng::toArray = -> [@lat(), @lng()]
	G.LatLng::toHash  = -> lat: @lat(), lng: @lng()
	G.LatLng::coordStr = -> @lat().toFixed(7) + ',' + @lng().toFixed(7)
	# Object::coordStr = -> @lat.toFixed(7) + ',' + (@lon or @lng).toFixed(7)

	class WhichBus.Views.GoogleMap extends Backbone.View
		initialize: ->
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

		resize: -> G.event.trigger @map, 'resize'

		# create a G.LatLng from pretty much any input format
		# array [lat,lng] | object {lat,lng} | function args (lat,lng)
		latlng: (param) ->
			if param instanceof G.LatLng then param
			# create as an array [lat, lon]
			else if _.isArray param then new G.LatLng param[0], param[1]
			# or as a hash { lat:?, lon:? }
			else if _.isObject param then new G.LatLng param.lat, param.lon or param.lng
			# or as two parameters latlng(lat, lon)
			else if parseInt arguments[0] # must be numbers
				new G.LatLng(arguments[0], arguments[1] ? arguments[0])
			# otherwise, fail and return null
			else null

		# create a G.Marker and optionally add it to the map.
		# accepts two formats: 
		#  1. marker([true,] 'marker', [x,y], [icon])
		#  2. marker([true,] {options})
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

		# move the given marker to the given position, optionally adding it to the map
		moveMarker: (marker, position, add) ->
			pos = @latlng position
			if pos
				marker.setPosition pos
				if add then @addLayer marker
			@

		# create a polyline from the encoded points string
		polyline: (points, color = '#000', weight = 5, opacity = 0.6) ->
			points = G.geometry.encoding.decodePath(points)
			new G.Polyline
				path: points,
				strokeColor: color,
				strokeWeight: weight,
				strokeOpacity: opacity

		# create an array of polylines from an array of points
		multiPolyline: (polylinesArray, color) ->
			# TODO: replace with _.map
			polylines = []
			for poly in polylinesArray
				polylines.push @polyline(poly, color)
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

		# MAP EVENT BINDERS
		onMapEvent: (overlay, event, callback) ->
			G.event.addListener overlay, event, callback

		offMapEvent: (listener) ->
			G.event.removeListener listener
			
	# Symbols:
	# 	Circle: G.SymbolPath.CIRCLE
	# 				fillColor: @segmentColors[leg.mode] ? 'black'
	# 				fillOpacity: 0.8
	# 				strokeColor: 'black'
	# 				strokeWeight: 1
	# 				scale: 5.5
