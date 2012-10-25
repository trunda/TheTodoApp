class TheTodoApp.Libs.FayeSubscriber
  rootUrl: 'http://localhost:9292/faye'

  constructor: (@collection, @channel) ->
    @client = new Faye.Client(@rootUrl)
    @subscribe()

  subscribe: ->
    @client.subscribe "/sync/#{@channel}", @receive

  receive: (message) =>
    console.log "Received push message", message
    @[event](arguments) for event, arguments of message

  update: (params) ->
    @collection.get(id).set(attrs) for id, attrs of params

  create: (params) ->
    @collection.add(new @collection.model(attrs)) for id, attrs of params

  destroy: (params) ->
    @collection.remove(@collection.get(id)) for id, attrs of params