window.app.views.Window = Backbone.View.extend
  el: window

  events:
    resize: 'resizeParent'
    message: 'iframeCommunication'

  initialize: (options) ->
    _.bindAll(this) #<-- remove this later and replace with judicious =>'ing

    @listenTo app.events,
      'change:height': @resizeParent

  fullHeight: ->
    Math.max $('body').height(), @facebookPopupHeight()

  facebookPopupHeight: ->
    do ( fbIframe = $('.facebook iframe') ) ->
      fbIframe.height() + fbIframe.offset()?.top

  resizeParent: _.debounce(->
    @callParent
      action: 'resize'
      args: height: @fullHeight()
  , 50)

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
