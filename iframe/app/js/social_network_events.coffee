# async 'ready' handlers
window.twttr = (t =
  _e: []
  ready: (f) ->
    t._e.push f
)

twttr.ready ->
  twttr.events.bind "tweet", (event) ->
    app.events.trigger "share:twitter"
