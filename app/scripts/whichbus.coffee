# Libraries & Plugins
define ["jquery", "lodash", "backbone", "libs/backbone.layoutmanager", "format", "Constants"], ($, _, Backbone, Geocode, Format, Constants) ->
  # Provide a global location to place configuration settings and module creation.
  app = 
    # The root path to run the application.
    root: "/"
    # API URLs for Backbone models
    otp: 'http://dev.whichb.us/api/otp/'
    api: 'http://dev.whichb.us/workshop/'
    # nested objects for modules
    Views: {}
    Models: {}
    Collections: {}
    # and don't forget the constants
    Constants: Constants
  
  # Localize or create a new JavaScript Template object.
  JST = window.JST = window.JST or {}
  
  # Configure LayoutManager with Backbone Boilerplate defaults.
  Backbone.Layout.configure
    manage: true

    prefix: 'templates/'

    fetch: (path) ->
      path = path + ".html"
      unless JST[path]
        $.ajax(
          url: app.root + path
          async: false
        ).then (contents) ->
          JST[path] = _.template(contents)
      JST[path]
  
  # Mix Backbone.Events, modules, and layout management into the app object.
  _.extend app, Backbone.Events, Format,
    # Create a custom object with a nested Views object.
    module: (additionalProps) ->
      _.extend
        Views: {}
      , additionalProps

    # Helper for using layouts.
    useLayout: (name) ->
      # If already using this Layout, then don't re-inject into the DOM.
      return @layout  if @layout and @layout.options.template is name
      # If a layout already exists, remove it from the DOM.
      @layout.remove()  if @layout
      # Create a new Layout.
      layout = new Backbone.Layout
        template: 'layouts/' + name
        className: "layout " + name
        id: "layout"
      # Insert into the DOM.
      $("#whichbus").empty().append layout.el
      # Render the layout.
      layout.render()
      # Cache the refererence.
      @layout = layout
      # Return the reference, for chainability.
      layout

