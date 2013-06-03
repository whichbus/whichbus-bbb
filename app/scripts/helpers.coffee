define ['format'], (Format) ->
	Handlebars.registerHelper 'safe', (string) -> new Handlebars.SafeString string

	Handlebars.registerHelper 'formatTime', (time) -> if time then Format.format_time time

	Handlebars.registerHelper 'formatTime24', (time) -> if time then Format.format_time_24 time

	Handlebars.registerHelper 'formatDate', (date) -> if date then Format.format_date date

	Handlebars.registerHelper 'formatDuration', (time) -> Format.format_duration time

	Handlebars.registerHelper 'fmtDuration', (time) -> Format.format_duration time, true

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

	Handlebars.registerHelper 'ifeq', (value, target, options) ->
		if value is target then options.fn(this) else options.inverse(this)

	Handlebars.registerPartial 'copyright', ->
		JST['partials/copyright']()

	Handlebars.registerPartial 'social_media', ->
		JST['partials/social_media']()


