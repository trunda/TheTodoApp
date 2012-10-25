class TheTodoApp.Views.Task extends Backbone.View
  template: JST['tasks/task']
  tagName: 'li'

  events:
    'click .delete' : 'destroyTask'
    'click .toggle' : 'toggleTask'

  initialize: ->
    @model.on('change', @render)
    @model.on('remove', @removeTask)

  render: =>
    @$el.html(@template(task: @model))
    if @model.get('completed') then @$el.addClass('completed') else @$el.removeClass('completed')
    this

  removeTask: =>
    @$el.remove()

  toggleTask: =>
    @model.toggle().save()

  destroyTask: (event) =>
    event.preventDefault()
    @model.destroy()