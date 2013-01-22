define ['whichbus'], (WhichBus) ->
	class WhichBus.Models.Segment extends Backbone.Model

	class WhichBus.Collections.Segments extends Backbone.Collection
		model: WhichBus.Models.Segment