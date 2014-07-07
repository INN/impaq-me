#= require facebook-connect-api-all
#= require_self

window.fb = (b =
  _e: []
  ready: (f) ->
    b._e.push f
)

window.fbAsyncInit = ->
  appId = window.impaqme['facebook_app_id']
  facebookShortlink = window.impaqme['facebook_shortlink']

  FB.init(appId: appId, xfbml: true)

  FB.getLoginStatus (login) ->
    console?.log("loginStatus")
    console?.log(arguments...)
    if login.status == "unknown" || login.status == "not_authorized"
      FB.ui
        method: 'login'
        display: 'iframe'
        appId: appId
      , (loginAgain) =>
        console?.log("login callback")
        console?.log(arguments...)
        facebookShare(appId, facebookShortlink) if fb.status != "unknown"
      , {scope: 'public_profile,publish_actions', return_scopes: true}
    else
      facebookShare(appId, facebookShortlink)


facebookShare = (appId, facebookShortlink) ->
  FB.ui
    method: 'share'
    display: 'iframe'
    href: "#{location.origin}/#{facebookShortlink}"
    appId: appId
  , (response) ->
    console?.log("FB.ui")
    console?.log(arguments...)
    return if !response? || response.error_code?
    app.events.trigger('share:facebook')
