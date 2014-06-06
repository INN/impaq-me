window.app.views.WidgetButton = class WidgetButton extends Backbone.View
  events:
    click: "click"

  initialize: (options) ->
    @listenTo @model,
      "change:open": @openChanged

  click: (e) =>
    @model.set "open", not @model.get("open")
    app.services.Analytics.trackEvent "widget", (if @model.get("open") then "open" else "close"), "secondary_button"

  openChanged: (model, open, options) =>
    @$el.toggleClass "opened", open

  render: =>
    @$el.html '<button class="toggle">'
    this
