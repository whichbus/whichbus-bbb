# Set the require.js configuration for your application.
require.config
  # Initialize the application with the main application file.
  deps: ["main"]
  paths:
    # JavaScript folders.
    libs: "../scripts/libs"
    
    # Libraries.
    jquery: "../scripts/libs/jquery"
    lodash: "../scripts/libs/lodash"
    backbone: "../scripts/libs/backbone"
    bootstrap: "../scripts/libs/bootstrap"

  shim:
    # Backbone library depends on lodash and jQuery.
    backbone:
      deps: ["lodash", "jquery"]
      exports: "Backbone"
    
    # Backbone.LayoutManager depends on Backbone.
    "libs/backbone.layoutmanager": ["backbone"]

