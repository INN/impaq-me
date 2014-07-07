window.app.views.Share = class Share extends Backbone.View
  template: new window.app.Template("share")

  events:
    "click .email": "emailClick"
    "click .custom-fb-share-button": "facebookClick"

  initialize: (options) ->
    @views = button: new app.views.WidgetButton(model: @model)
    @listenTo @model,
      "change:mode": @modeChanged
      "change:open": @openChanged

  modeChanged: (model, mode, options) =>
    @$el.toggle mode is "widget"

  openChanged: (model, open, options) =>
    @$el.toggle(open) unless @model.get("mode") == "widget"

  emailClick: (event) =>
    app.events.trigger("share:email")

  facebookClick: =>
    console?.log("loginStatus")
    console?.log(arguments...)
    if fb.loginStatus.status == "unknown" || fb.loginStatus.status == "not_authorized"
      FB.login (loginAgain) =>
        fb.loginStatus = loginAgain
        console?.log("login callback")
        console?.log(arguments...)
        @facebookShare() if fb.loginStatus.status != "unknown"
      , {scope: 'public_profile,publish_actions', return_scopes: true}
    else
      @facebookShare()


  facebookShare: =>
    FB.ui
      method: 'share'
#      display: 'popup'
      href: "#{location.origin}/#{@model.get('facebook_shortlink')}"
      appId: @model.get('facebook_app_id')
    , (response) ->
      console?.log("FB.ui")
      console?.log(arguments...)
      return if !response? || response.error_code?
      app.events.trigger('share:facebook')


  render: =>
    data = @model.toJSON()
    _(data).extend
      twitter_shortlink: location.origin + "/" + data.twitter_shortlink
      email_shortlink: location.origin + "/" + data.email_shortlink

    @$el.html @template.fill(data)
    window.app.helpers.Replacer.replace @$el, @model, true
    @assign "[data-subview='WidgetButton']": @views.button
    this
