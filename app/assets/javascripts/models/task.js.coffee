class TheTodoApp.Models.Task extends Backbone.Model
  urlRoot: "/api/tasks"

  toggle: ->
    @set('completed', !@get('completed'))