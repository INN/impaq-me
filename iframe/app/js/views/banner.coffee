window.app.views.Banner = class Banner extends Backbone.View
  template: JST["app/templates/banner.us"]

  events:
    click: "click"

  initialize: (options) ->
    @views =
      header: new app.views.BannerHeader(model: @model)
      info: new app.views.BannerInfo(model: @model)
      close: new app.views.BannerClose(model: @model)

    @listenTo @model,
      "change:minimize": @minimize

  maximize: =>
    @views.info.$el.show()
    app.events.trigger "change:height"

  minimize: =>
    return  if @model.get("open")
    @views.info.$el.hide()
    app.events.trigger "change:height"

  click: =>
    @model.set "open", not @model.get("open")
    app.services.Analytics.trackEvent "widget", (if @model.get("open") then "open" else "close"), "banner"

  timeout: =>
    @minimize()
    app.services.Analytics.trackEvent "banner", "minimize", "timeout", `undefined`, true

  render: ->
    @minimizer = window.setTimeout(@timeout, 10000)
    @$el.html @template(@model.toJSON())
    @assign
      "[data-subview='BannerHeader']": @views.header
      "[data-subview='BannerInfo']": @views.info
      "[data-subview='BannerClose']": @views.close

    this
