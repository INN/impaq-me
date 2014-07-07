#= require facebook-connect-api-all
#= require_self

window.fb = (b =
  _e: []
  ready: (f) ->
    b._e.push f
)

window.fbAsyncInit = ->
  app = window.opener.app
  appId = window.opener.impaqme['facebook_app_id']
  facebookShortlink = window.opener.impaqme['facebook_shortlink']

  FB.init(appId: appId, xfbml: true)

  after = (action) ->
    window.location.search.indexOf("post_#{action}") != -1

  FB.getLoginStatus (login) ->
    if !after('login') && (login.status == "unknown" || login.status == "not_authorized")
      debugger
      FB.ui
        method: 'login'
        display: 'page'
        client_id: appId
        state: 'lies'
        redirect_uri: 'http://demo.testdouble.com/facebook_popup?post_login'
        appId: appId
        scope: 'public_profile,publish_actions'
    else if after('login') && login.status != "unknown"
      debugger
      FB.ui
        method: 'share'
        display: 'page'
        state: 'lies'
        redirect_uri: 'http://demo.testdouble.com/facebook_popup?post_share'
        href: "#{location.origin}/#{facebookShortlink}"
        appId: appId
    else if after('share')
      debugger
      app.events.trigger('share:facebook')
      window.close()
