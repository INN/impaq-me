(($) ->

  window.impaq = $.extend true, {}, window.impaq,
    $: $
    me:
      widgets: []
      config:
        route: "widget"
  impaq.me.config["iframe_host"] = "//www.impaq.me" unless impaq.me.config["iframe_host"]?

  class Widget
    id: null          # provided by options to constructor
    config: null      # provided by options to constructor
    placeholder: null # provided by options to constructor

    constructor: (options) ->
      $.extend(@, options)
      @$el = $(@compile()).replaceAll(@placeholder)
      @iframe = @$el.find("iframe")[0]
      $(@iframe).on("load", @wireUpCommunication)
      $(@iframe).on("load", @bindScroll) if @config?.route is "banner"

    template: (data) ->
      """
      <div class="impaq-me-widget">
        <iframe
          src="#{data['iframe_host']}/iframe?mode=#{data['route']}&article_url=#{data['article_url']}&article_title=#{data['article_title']}#{data['extra_iframe_query_params'] || ''}"
          style="width:100%; height:0; border:0; display:block;"
          scrolling="no"
          frameborder="0"></iframe>
      </div>
      """

    templateData: ->
      $.extend({}, impaq.me.config, @config,
        article_url: encodeURIComponent(@articleURL())
        article_title: encodeURIComponent(@articleTitle())
      )

    articleURL: ->
      @placeholder.data("url") || $("link[rel=canonical]").attr("href") || window.location

    articleTitle: ->
      @placeholder.data("title") || document.title

    compile: ->
      @template(@templateData())

    resize: (height) ->
      @mostRecentResizeRequest = height
      unless @animating
        $(@iframe).animate {height}, =>
          @animating = false
          @resize(@mostRecentResizeRequest) if height != @mostRecentResizeRequest
        @animating = true

    remove: ->
      @$el.remove()

    respondToChild: (data) ->
      if data.action == "close" then @remove() else @resize(data.args.height)

    minimizeChild: =>
      $(window).unbind("scroll", @minimizeChild)
      @iframe.contentWindow.postMessage(JSON.stringify(
        widget_id: @id
        action: "minimize"
      ), @iframe.src)

    bindScroll: (event) =>
      $(window).scroll(@minimizeChild)

    wireUpCommunication: (e) =>
      @iframe.contentWindow.postMessage(JSON.stringify(
        widget_id: @id
        action: "initialize"
      ), @iframe.src)

  $(window).on "message", (e) ->
    return unless e?.originalEvent?.origin?.match(impaq.me.config.iframe_host)?
    try
      data = $.parseJSON(e.originalEvent.data)
    catch err
      return
    return unless data.widget_id?
    impaq.me.widgets[data.widget_id].respondToChild(data)

  $(".impaq-me-placeholder").each (id, placeholder) ->
    impaq.me.widgets[id] = new Widget
      id: id
      placeholder: $(placeholder)


  if window.location.search.match(/shared_via_impaq_me=/)?
    impaq.me.widgets.push new Widget
      id: impaq.me.widgets.length
      placeholder: $("<div>").prependTo("body")
      config:
        route: "banner"
) jQuery.noConflict(true)
