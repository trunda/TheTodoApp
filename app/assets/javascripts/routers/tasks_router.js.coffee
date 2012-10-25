class TheTodoApp.Routers.Tasks extends Backbone.Router
  routes:
    '' : 'index'
    'task/:id': 'show'

  initialize: ->
    @collection = new TheTodoApp.Collections.Tasks
    @collection.fetch()

  index: ->
    (view = new TheTodoApp.Views.TasksIndex()).setCollection(@collection)
    $("#container").html(view.render().el)

  show: (id) ->
    alert "The task id is #{id}"