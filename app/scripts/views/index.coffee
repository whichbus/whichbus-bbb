define ['whichbus'], (WhichBus) ->
	WhichBus.Views.Index = Backbone.View.extend
		template: 'splash'

		className: 'container-fluid unselectable'

		events:
			'submit form': 'loadPlan'
			# 'click #from-location': 'fromCurrentLocation'
			# 'click #to-location': 'toCurrentLocation'

		initialize: ->
			# view setup

		serialize: -> 
			# @model.toJSON()

		beforeRender: ->
			# set and insert views

		afterRender: ->
			# after render, cache selectors

		loadPlan: (event) ->
			event.preventDefault()
			from = @$('#from_query').val().replace(/\s/g, '+')
			to = @$('#to_query').val().replace(/\s/g, '+')
			if (to == null || to.length <= 3)
				@$('#to-location').addClass('btn-danger')
			else
				@$('#to-location').removeClass('btn-danger')
			if (from == null || from.length <=3)
				@$('#from-location').addClass('btn-danger')
			else
				@$('#from-location').removeClass('btn-danger')
			if (to? and from? and to.length > 3 and from.length > 3)
				@remove()
				Backbone.history.navigate "plan/#{from}/#{to}", true

		# fromCurrentLocation: -> 
		# 	Transit.Geocode.getCurrentPosition (-> @$("#from_query").val('here')), ->
		# 		$('button.geolocate').attr('disabled', true)


		# toCurrentLocation: -> 
		# 	Transit.Geocode.getCurrentPosition (-> @$("#to_query").val('here')), ->
		# 		$('button.geolocate').attr('disabled', true)