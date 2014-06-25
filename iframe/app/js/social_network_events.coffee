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
  FB.init(xfbml: true)

twttr.ready ->
  twttr.events.bind "tweet", (event) ->
    app.events.trigger "share:twitter"

fb.ready ->
  $('.some-fb-share-button').on 'click', (e) ->
    $button = $(e.target)
    FB.ui
      method: 'share'
      href: $button.data('href')
      appId: "565743950200653"
    , (response) ->
      console.log "Result of facebook dialog", response
      app.events.trigger "share:facebook"

  # FB.Event.subscribe "edge.create", (response) ->
