define ['whichbus'], (WhichBus) ->
	WhichBus.Views.Index = Backbone.View.extend
		template: 'splash'

		className: 'unselectable'

		events:
			'submit form': 'loadPlan'
			'click #from-location': 'fromCurrentLocation'
			'click #to-location': 'toCurrentLocation'

		beforeRender: ->
			# HACK to make this view appear fullscreen without changing the layout
			# see main.scss > .layout.splash
			$('#layout').addClass('splash')

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
				Backbone.history.navigate "plan/#{from}/#{to}", true

		fromCurrentLocation: -> @$("#from_query").val('here')
			# Transit.Geocode.getCurrentPosition (-> @$("#from_query").val('here')), ->
			# 	$('button.geolocate').attr('disabled', true)

		toCurrentLocation: -> @$("#to_query").val('here')
			# Transit.Geocode.getCurrentPosition (-> @$("#to_query").val('here')), ->
			# 	$('button.geolocate').attr('disabled', true)

		cleanup: -> $('#layout').removeClass('splash')
