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
    facebookWindow = window.open('/facebook_popup', null, 'width=200,height=200')
    facebookWindow.impaqme = window.impaqme
    facebookWindow.app = window.app

  render: =>
    data = @model.toJSON()
    _(data).extend
      twitter_shortlink: location.origin + "/" + data.twitter_shortlink
      email_shortlink: location.origin + "/" + data.email_shortlink

    @$el.html @template.fill(data)
    window.app.helpers.Replacer.replace @$el, @model, true
    @assign "[data-subview='WidgetButton']": @views.button
    this
