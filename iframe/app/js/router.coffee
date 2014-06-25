window.app.Router = class Router extends Backbone.Router
  initialize: ->

    # not using Backbone's real routing
    # Backbone's fragment-based routing causing the host page to scroll:
    # test case: http://jsfiddle.net/dTQEE/1/
    @routes =
      widget: @widget_closed
      "widget/closed": @widget_closed
      "widget/open": @widget_open
      banner: @banner_maximized
      "banner/maximized": @banner_maximized
      "banner/minimized": @banner_minimized

  start: =>
    query = new URI().query(true)
    @routes[query.mode]()

  widget_open: =>
    app.services.Analytics.trackPageview "/widget/open"
    $("main").empty().append app.views.widget.render().el
    app.models.widget.set
      mode: "widget"
      open: true

  widget_closed: =>
    app.services.Analytics.trackPageview "/widget/closed"
    $("main").empty().append app.views.widget.render().el
    app.models.widget.set
      mode: "widget"
      open: false

  banner_maximized: =>
    app.services.Analytics.trackPageview "/banner/maximized"
    $("main").empty().append(app.views.banner.render().el).append app.views.widget.render().el
    app.views.banner.maximize()
    app.models.widget.set
      mode: "banner"
      open: false

  banner_minimized: =>
    app.services.Analytics.trackPageview "/banner/minimized"
    $("main").empty().append(app.views.banner.render().el).append app.views.widget.render().el
    app.views.banner.minimize()
    app.models.widget.set
      mode: "banner"
      open: false


jQuery ($) ->
  window.app.router = new window.app.Router()
  window.app.models.widget = new app.models.Widget(window.impaqme)
  window.app.models.social = new app.models.Social(window.impaqme)
  _(window.app.views).extend
    window: new app.views.Window(model: app.models.widget)
    banner: new app.views.Banner(model: app.models.widget)
    widget: new app.views.Widget(model: app.models.widget)

  app.router.start()
