define ->
	Handlebars.registerHelper 'safe', (string) -> new Handlebars.SafeString string

	Handlebars.registerHelper 'formatTime', (time) -> WhichBus.format_time time

	Handlebars.registerHelper 'formatDuration', (time) -> WhichBus.format_duration time

	Handlebars.registerHelper 'fmtDuration', (time) -> WhichBus.format_duration time, true

	Handlebars.registerHelper 'itinerarySummary', (legs) ->
		index = 0
		stops = _.map(_.filter(legs, (leg) -> leg.mode not in ['WALK', 'BIKE']), (leg) -> 
			index++
			expandable = if index > 2 then ' expandable' else ''
			route = if leg.mode == 'FERRY' then 'FERRY' else leg.route
			"<span class='btn btn-route#{expandable}'>#{route}</span>"
		).join(' ')
		stops = "#{stops} <span class='btn btn-route expand'>+#{index-2}</span>" if index > 2
		new Handlebars.SafeString stops
