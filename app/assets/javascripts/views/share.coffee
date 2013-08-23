window.app.views.Share = class Share extends Backbone.View
  template: JST["share"]

  events:
    "click .email": "emailClick"

  initialize: (options) ->
    @views = button: new app.views.WidgetButton(model: @model)
    @listenTo @model,
      "change:mode": @modeChanged
      "change:open": @openChanged

  modeChanged: (model, mode, options) =>
    @$el.toggle mode is "widget"

  openChanged: (model, open, options) =>
    @$el.toggle open  if @model.get("mode") isnt "widget"

  emailClick: (event) =>
    app.events.trigger "share:email"

  render: =>
    data = @model.toJSON()
    _(data).extend
      facebook_shortlink: location.origin + "/" + data.facebook_shortlink
      twitter_shortlink: location.origin + "/" + data.twitter_shortlink
      email_shortlink: location.origin + "/" + data.email_shortlink

    @$el.html @template(data)
    @assign "[data-subview='WidgetButton']": @views.button
    this
