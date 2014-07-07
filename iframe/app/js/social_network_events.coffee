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

window.fbAsyncInit = ->
  fb.ready = (f) -> f()
  _.invoke fb._e, "call"

fb.ready ->
  FB.init(appId: window.impaqme.facebook_app_id, xfbml: true)
  setInterval updateLoginStatus = ->
    FB.getLoginStatus (login) ->
      fb.loginStatus = login
    , true
  , 1000 * 5 * 60
  updateLoginStatus()



twttr.ready ->
  twttr.events.bind "tweet", (event) ->
    app.events.trigger "share:twitter"
