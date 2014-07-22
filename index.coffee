# This is a Coffeescript adapation of the hubot-mock-adapter
# by Brian Lalor: https://github.com/blalor/hubot-mock-adapter

_ = require("underscore")
Adapter = require("hubot/src/adapter")

class MockAdapter extends Adapter
  constructor: ->
    super

    @send = @_genericEmitter("send")
    @reply = @_genericEmitter("reply")
    @topic = @_genericEmitter("topic")
    @play  = @_genericEmitter("play")

  run: ->
    @emit("connected")

  close: ->
    @emit("closed")

  _genericEmitter: (event) =>
    return (envelope) =>
      strings = _.rest(arguments)

      # use a `setTimeout` to make the call execute
      # in the main context rather than inside hubot
      setTimeout =>
        @emit(event, envelope, strings)
      , 0


module.exports.use = (robot) ->
  return new MockAdapter(robot)