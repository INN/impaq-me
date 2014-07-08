window.app.views.Widget = class Widget extends Backbone.View
  template: JST["app/templates/widget.us"]

  initialize: (options) ->
    @views =
      header: new app.views.WidgetHeader(model: @model)
      share: new app.views.Share(model: @model)
      body: new app.views.WidgetBody(model: @model)
      footer: new app.views.WidgetFooter(model: @model)

    @listenTo @model,
      "change:mode": @modeChanged
      "change:open": @openChanged

    @listenTo app.events,
      "share:twitter": @shared
      "share:facebook": @shared
      "share:email": @shared
      "expandHeightDynamically": @expandHeightDynamically

  modeChanged: (model, mode, options) =>
    app.events.trigger "change:height"

  openChanged: (model, open, options) =>
    @$("#widget .cta").css(margin: (if open then "12px 0 -4px" else 0)).promise().then ->
      app.events.trigger "change:height"

  expandHeightDynamically: (expandForThisBehavior) =>
    $box = @$('.box').addClass('facebook-tall')
    breatheInterval = setInterval breathe = ->
      $fbIframe = $('#fb-root iframe.FB_UI_Dialog')
      $fbIframe.css(minHeight: 350)
      $box.css(minHeight: $fbIframe.height() + 20)
      app.events.trigger('change:height')
    , 100
    breathe()
    expandForThisBehavior ->
      clearInterval(breatheInterval)
      $box.removeClass('facebook-tall').attr('style', '')
      app.events.trigger('change:height')

  shared: =>
    @model.set "open", true
    app.events.trigger "change:height"

  render: =>
    @$el.html @template(@model.toJSON())
    @assign
      "[data-subview='WidgetHeader']": @views.header
      "[data-subview='Share']": @views.share
      "[data-subview='WidgetBody']": @views.body
      "[data-subview='WidgetFooter']": @views.footer
    this
