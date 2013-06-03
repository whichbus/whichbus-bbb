define ['whichbus', 'models/plan', 'bootstrap/bootstrap-button'], (WhichBus) ->
	class WhichBus.Views.Options extends Backbone.View
		template: 'plan-options'

		events:
			'submit form': 'updatePlan'

		serialize: -> @model.toJSON()

		afterRender: -> @$el.button()

		updatePlan: (e) ->
			e.preventDefault()

			date = @$('#date').val()
			time = @$('#time').val()
			arriveBy = @$('#arriveBy .btn.active').text()
			maxWalkDistance = @$('#maxWalkDistance .btn.active').data 'distance'
			# preferredRoutes = @$('#preferredRoutes').val()?.split(', ') or null
			console.log "Update plan options: #{arriveBy} #{time} #{date}, walk #{maxWalkDistance}m"

			@model.set
				date: WhichBus.parse_date("#{date} #{time}")
				arrive_by: arriveBy is 'Arrive'
				maxWalkDistance: maxWalkDistance
				# preferredRoutes: preferredRoutes
				, silent: true
			@model.clear().fetch()
			