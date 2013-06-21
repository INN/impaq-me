# using jQuery for extend(), replaceAll, find, on(event), proxy(bind), attr(), height(), parseJSON, prependTo 

# documented in case we can give zepto or ender a try (to shrink footprint). or maybe a custom build 
(($) ->
  window.impaq = $.extend({}, window.impaq,
    $: $
    me:
      config:
        route: "widget"
        
        # iframe_src: '//localhost:3000/iframe'
        iframe_src: "//www.impaq.me/iframe"

      widgets: []
  )
  Widget = (options) ->
    $.extend this, options
    html = @compile()
    @$el = $(html).replaceAll(@placeholder)
    @iframe = @$el.find("iframe")[0]
    $(@iframe).on "load", $.proxy(@wireUpCommunication, this)
    $(@iframe).on "load", $.proxy(@bindScroll, this)  if @config and @config.route is "banner"

  Widget:: =
    template: (data) ->
      "<div class=\"impaq-me-widget\"><iframe src=\"" + data.iframe_src + "?mode=" + data.route + "&article_url=" + data.article_url + "&article_title=" + data.article_title + "\" style=\"width:100%; height:0; border:0; display:block;\" scrolling=\"no\" frameborder=\"0\"></iframe></div>"

    templateData: ->
      $.extend {}, impaq.me.config, @config,
        article_url: encodeURIComponent(@articleURL())
        article_title: encodeURIComponent(@articleTitle())


    articleURL: ->
      @placeholder.data("url") or $("link[rel=canonical]").attr("href") or window.location

    articleTitle: ->
      document.title

    compile: ->
      @template @templateData()

    resize: (height) ->
      $(@iframe).animate height: height

    remove: ->
      @$el.remove()

    respondToChild: (data) ->
      if data.action is "close"
        @remove()
      else
        @resize data.args.height

    minimizeChild: ->
      $(window).unbind "scroll", @minimizeChild
      @iframe.contentWindow.postMessage JSON.stringify(
        widget_id: @id
        action: "minimize"
      ), @iframe.src

    bindScroll: (event) ->
      $(window).scroll $.proxy(@minimizeChild, this)

    wireUpCommunication: (e) ->
      @iframe.contentWindow.postMessage JSON.stringify(
        widget_id: @id
        action: "initialize"
      ), @iframe.src

  $(window).on "message", (e) ->
    
    # console.log("message received", e);
    data = $.parseJSON(e.originalEvent.data)
    impaq.me.widgets[data.widget_id].respondToChild data

  $(".impaq-me-placeholder").each (id, placeholder) ->
    impaq.me.widgets[id] = new Widget(
      id: id
      placeholder: $(placeholder)
    )

  if window.location.search.match(/shared_via_impaq_me=/)
    widget = new Widget(
      id: impaq.me.widgets.length
      placeholder: $("<div>").prependTo("body")
      config:
        route: "banner"
    )
    impaq.me.widgets.push widget
) jQuery.noConflict(true)
