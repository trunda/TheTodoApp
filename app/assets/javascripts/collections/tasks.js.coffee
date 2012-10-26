class TheTodoApp.Collections.Tasks extends Backbone.Collection
  model: TheTodoApp.Models.Task
  url: "/api/tasks"

  initialize: ->
    # synchronizace se serverem
    new TheTodoApp.Libs.FayeSubscriber(@, 'tasks')

  comparator: (model) ->
    -1 * model.get('position')

  saveOrder: () ->
    data = @map((task) -> { id: task.get('id'), position: task.get('position') })
    $.post("#{@url}/sort", tasks: data)