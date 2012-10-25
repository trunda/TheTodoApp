class TheTodoApp.Views.TasksIndex extends Backbone.View
  template: JST['tasks/index']
  events:
    'submit #add-task' : 'createTask'
    'click li': 'itemClicked'

  setCollection: (collection) ->
    @collection = collection
    @collection.on('reset', @render)
    @collection.on('add', (task) => @addTask(task, false))
    @collection.on('change:position', => @collection.sort(); @render)
    @collection.on('remove', (model) => delete @taskViews[model.get('id')] )
    @render

  render: =>
    $(document).off('keydown', @keydown).on('keydown', @keydown)
    @taskViews = {}
    $(@el).html(@template())
    @$('ul').sortable
      axis: 'y'
      update: @updateSort
      distance: 10

    @collection.each (task) =>
      @addTask(task, true)

    this

  addTask: (task, append = false) =>
    @taskViews[task.get('id')] = view = new TheTodoApp.Views.Task(model: task)
    method = if append then 'append' else 'prepend'
    @$('#tasks')[method](view.render().el)

  createTask: (event) =>
    event.preventDefault()
    attributes =
      title: @$('input[name=title]').val()
      position: if @collection.length > 0 then @collection.max((task) -> task.get('position')).get('position') + 1 else 0
    (new @collection.model(attributes)).save()
    @$('input[name=title]').val('')

  updateSort: (event, model, position) =>
    for key, view of @taskViews
      view.model.set('position', (@$('li').size() - view.$el.index() - 1))
    @collection.saveOrder()

  itemClicked: (event) =>
    $(event.target).parent().find('li').removeClass('selected');
    $(event.target).addClass('selected')

  # Podpora klávesnice
  keydown: (event) =>
    return if $(':focus').length
    switch event.keyCode
      # Šipky
      when 38, 40
        return if (count = @$('li').size() - 1) < 0
        shift = if event.keyCode is 38 then -1 else 1
        index = @$('li.selected').index()
        index += shift
        if index < 0 then index = count else if index > count then index = 0
        @$('li').removeClass('selected').eq(index).addClass('selected')
        false
      # Mezerník - toggle
      when 32
        selected.model.toggle().save() if (selected = _.find(@taskViews, (item, key) -> @$('li.selected').is(item.$el)))
      # Delete - smazat
      when 46
        selected.model.destroy() if (selected = _.find(@taskViews, (item, key) -> @$('li.selected').is(item.$el)))


