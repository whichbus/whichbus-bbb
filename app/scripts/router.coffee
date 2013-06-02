define ['whichbus', 'views/index', 'views/navbar', 'views/map', 'views/plan', 'views/about', 'views/settings', 'views/options'], (WhichBus) ->
  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend
    routes:
      '': 'index'
      '?:params': 'index'
      'plan/:from/:to': 'plan'
      'plan/:from/:to?:params': 'plan'
      'to/:to': 'goto'
      'about' : 'about'
      'options': 'options'
      'settings': 'settings'
      '*splat': 'indexRedirect'

    initialize: ->
      WhichBus.useLayout 'index'
      WhichBus.layout.setView('#navbar', @navbar = new WhichBus.Views.Navbar()).render()
      WhichBus.layout.setView('#map', WhichBus.Map = new WhichBus.Views.GoogleMap()).render()

    # one method for every page to call to make sure stuff is working
    setupPage: ->
      @navbar.render()
      WhichBus.Map.resize()

    # if the user types nonsense, send them home!
    indexRedirect: ->
      Backbone.history.navigate '', true

    index: ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.Index()).render()
      @setupPage()

    plan: (from, to, params) ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.Plan
        from: from
        to: to
      ).render()
      @setupPage()

    goto: (to) ->
      Backbone.history.navigate "plan/here/#{to}", true

    about: ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.About()).render()
      @setupPage()

    settings: ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.Settings()).render()
      @setupPage()

    options: ->
      WhichBus.layout.setView('#navigation', new WhichBus.Views.Options()).render()
      @setupPage()





