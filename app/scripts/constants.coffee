define ->
	G = google.maps
	
	TransitTypes: ['BUS', 'TRAM', 'FERRY']
	# the various Google Map Markers we use
	Markers:
		Start: new G.MarkerImage('/images/icons/icon-start-location.png', 
			new G.Size(33, 35), new G.Point(0, 0), new G.Point(11, 35))
		End: new G.MarkerImage('/images/icons/icon-end-location.png', 
			new G.Size(33, 35), new G.Point(0, 0), new G.Point(11, 35))
		Stop: '/images/icons/icon-busstop.png'
		StopDot: new G.MarkerImage('/images/icons/bus/dot.png', 
			new G.Size(17, 17), new G.Point(0, 0), new G.Point(6, 6), new G.Size(12, 12))
		Bus: '/images/icons/icon-busstop.png'
	# colors for segment polylines based on mode
	SegmentColors: 
		BUS: '#025d8c'
		BIKE: 'green'
		WALK: 'black'
		TRAM: '#1693a5'
		FERRY: '#f02311'

	Messages:
		AddressError: 'The address or business you entered could not be understood. Please try again.'
