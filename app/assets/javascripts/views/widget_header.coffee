window.app.views.WidgetHeader = class WidgetHeader extends Backbone.View
  template: new window.app.Template("widget_header")

  events:
    click: "click"

  initialize: ->
    @listenTo @model,
      "change:mode": @modeChanged

  click: =>
    isOpen = !@model.get("open")
    @model.set("open", isOpen)
    action = isOpen ? "open" : "close"
    app.services.Analytics.trackEvent("widget", action, "primary_button")

  modeChanged: (model, mode, options) =>
    @$el.toggle(mode is "widget")

  render: ->
    @$el.html @template.fill(@model.toJSON())
    this
