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

  facebookClick: (event) =>
    FB.ui
      method: 'share'
      href: $(event.target).data('href')
      appId: @model.get('facebook_app_id')
    , (response) ->
      app.events.trigger('share:facebook')

  render: =>
    data = @model.toJSON()
    _(data).extend
      facebook_shortlink: location.origin + "/" + data.facebook_shortlink
      twitter_shortlink: location.origin + "/" + data.twitter_shortlink
      email_shortlink: location.origin + "/" + data.email_shortlink

    @$el.html @template.fill(data)
    window.app.helpers.Replacer.replace @$el, @model, true
    @assign "[data-subview='WidgetButton']": @views.button
    this
