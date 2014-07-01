# async 'ready' handlers
window.twttr = (t =
  _e: []
  ready: (f) ->
    t._e.push f
)

window.fb = (b =
  _e: []
  ready: (f) ->
    b._e.push f
)

# facebook doesn't have a multi-handler 'ready' event, so we built one
window.fbAsyncInit = ->
  fb.ready = (f) -> f()
  _.invoke fb._e, "call"

fb.ready ->
  FB.init(appId: window.impaqme.facebook_app_id, xfbml: true)

twttr.ready ->
  twttr.events.bind "tweet", (event) ->
    app.events.trigger "share:twitter"
