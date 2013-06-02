define ['whichbus', 'models/plan', 'bootstrap/bootstrap-button'], (WhichBus) ->
	class WhichBus.Views.Options extends Backbone.View
		template: 'plan-options'

		afterRender: -> @$el.button()