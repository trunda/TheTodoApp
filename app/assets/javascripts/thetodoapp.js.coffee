window.TheTodoApp =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Libs: {}
  initialize: (data) ->
    @router = new TheTodoApp.Routers.Tasks()

    if (Backbone.history and not Backbone.history.started)
      Backbone.history.start()
      Backbone.history.started = true

$ ->
  TheTodoApp.Libs.FayeSubscriberOptions.rootUrl = url if (url = $('#container').data('fayeRootUrl'))
  TheTodoApp.initialize({})