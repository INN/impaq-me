window.app.views.Window = Backbone.View.extend
  el: window

  events:
    resize: 'resizeParent'
    message: 'iframeCommunication'

  initialize: (options) ->
    @listenTo app.events,
      'change:height': @resizeParent

  fullHeight: ->
    Math.max $('body').innerHeight(), @facebookPopupHeight()

  facebookPopupHeight: ->
    # visibilityHidden custom filter b/c jQuery's :visible is dumb
    do ( fbIframe = $('.facebook iframe:visible:not(:visibilityHidden)') ) ->
      (fbIframe.height() + fbIframe.offset()?.top) || 0

  resizeParent: _.throttle ->
    @callParent
      action: 'resize'
      args:
        height: @fullHeight()
  , 250

  closeParent: ->
    @callParent(action: 'close')

  callParent: (data) ->
    return unless @publisher?

    _(data).extend(widget_id: @publisher.widget_id)
    @publisher.window.postMessage(JSON.stringify(data), @publisher.hostname)

  iframeCommunication: (event) ->
    return unless event.originalEvent.origin.match(@model.get('article_domain'))?

    if JSON.parse(event.originalEvent.data).action == "minimize"
      app.models.widget.set(minimize: true)
      app.services.Analytics.trackEvent('banner', 'minimize', 'scroll', undefined, true)
    else
      @wireUpIframeCommunication(event)

  wireUpIframeCommunication: (event) ->
    this.publisher =
      widget_id: JSON.parse(event.originalEvent.data).widget_id
      window: event.originalEvent.source
      hostname: event.originalEvent.origin

    this.resizeParent()
