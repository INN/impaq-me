window.app.views.BannerClose = class BannerClose extends Backbone.View
  events:
    click: "close"

  close: =>
    app.views.window.closeParent()
    app.services.Analytics.trackEvent "banner", "close", "close_button", `undefined`, true

  render: =>
    @$el.html '<button class="close"><i class="icon-remove-sign" title="close"></i></button>'
    this
