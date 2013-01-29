define ['whichbus', 'models/arrival'], (WhichBus) ->
	class WhichBus.Views.RealTime extends Backbone.View
		template: 'partials/realtime'
		# el: false

		tagName: 'span'
		className: 'label'

		events: 
			'click': 'reload'

		initialize: (model, options) ->
			# fetch the arrival at this stop for this trip
			@model = new WhichBus.Models.Arrival
				agencyId: @options.stop.stopId.agencyId
				stopId: @options.stop.stopId.id
				tripId: @options.trip
			@model.on 'change', @render, @
			@model.fetch()

		afterRender: ->
			@$el.addClass @model.deltaClass()

		serialize: -> 
			# accepts option of scheduled time from OTP leg.
			# use this if model has not fetched yet.
			time:  @model.arrivalTime() or @options.scheduled
			delta: @model.readableDelta()
			labelClass: @model.deltaClass()

		reload: ->
			@model.fetch()
