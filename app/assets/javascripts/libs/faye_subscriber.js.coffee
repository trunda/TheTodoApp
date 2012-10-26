class TheTodoApp.Libs.FayeSubscriber
  @rootUrl = null

  constructor: (@collection, @channel) ->
    @client = new Faye.Client(TheTodoApp.Libs.FayeSubscriberOptions.rootUrl)
    @subscribe()

  subscribe: ->
    @client.subscribe "/sync/#{@channel}", @receive

  receive: (message) =>
    console.log "Received push message", message
    for event, arguments of message
      if @[event] then @[event](arguments) else @collection.trigger(event, arguments)

  update: (params) ->
    @collection.get(id).set(attrs) for id, attrs of params

  create: (params) ->
    @collection.add(new @collection.model(attrs)) for id, attrs of params

  destroy: (params) ->
    @collection.remove(@collection.get(id)) for id, attrs of params


TheTodoApp.Libs.FayeSubscriberOptions = { rootUrl: 'http://localhost:9292/faye'}