define ['whichbus'], (WhichBus) ->
	class WhichBus.Views.PlanError extends Backbone.View
		template: 'partials/address-error'

		className: 'alert alert-error show'

		events:
			'submit form': 'updatePlan'

		initialize: ->
			@error = @options.error or {}

		serialize: -> 
			title: 'Address Error!'
			error: @error
			hasFrom: @model.get('fromPlace')?
			hasTo: @model.get('toPlace')?

		updatePlan: (evt) ->
			evt.preventDefault()
			# get values from form
			from = @$('#fromQuery').val()
			to = @$('#toQuery').val()
			if from or to 
				# update model fields if they were updated in the form
				@model.set 'from', from, silent: true if from
				@model.set 'to',   to,   silent: true if to
				@model.fetch()
				# remove error view because we're done with it
				@remove()
			else Backbone.history.navigate '', true
