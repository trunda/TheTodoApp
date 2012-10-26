class TheTodoApp.Views.Task extends Backbone.View
  template: JST['tasks/task']
  tagName: 'li'

  events:
    'click .delete' : 'destroyTask'
    'click .toggle' : 'toggleTask'

  initialize: ->
    @model.on('change', (model, event) => @render() unless _.keys(event.changes).length is 1 and event.changes.position is true )
    @model.on('remove', @removeTask)

  render: =>
    console.log "Rendering task id=#{@model.get('id')}"
    classes = @$el.attr('class')
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