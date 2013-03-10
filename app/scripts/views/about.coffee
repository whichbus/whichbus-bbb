define ['whichbus'], (WhichBus) ->
    class WhichBus.Views.About extends Backbone.View
        template: 'about'

        beforeRender: ->
            # HACK to make this view appear fullscreen without changing the layout
            # see main.scss > .layout.splash
            $('#layout').addClass('splash')