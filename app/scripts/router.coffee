define ['whichbus', 'views/index', 'views/navbar', 'views/map', 'views/plan', 'views/about'], (WhichBus) ->
  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend
    routes:
      '': 'index'
      '?:params': 'index'
      'plan/:from/:to': 'plan'
      'plan/:from/:to?:params': 'plan'
      'about' : 'about'

    initialize: ->
      WhichBus.useLayout 'index'
      WhichBus.layout.setView('#navbar', new WhichBus.Views.Navbar()).render()
      WhichBus.layout.setView('#map', WhichBus.Map = new WhichBus.Views.GoogleMap()).render()

    index: ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.Index()).render()
      WhichBus.Map.resize()

    plan: (from, to, params) ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.Plan
        from: from
        to: to
      ).render()
      WhichBus.Map.resize()

    about: ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.About()).render()
      WhichBus.Map.resize()





