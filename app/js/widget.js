/* using jQuery for extend(), replaceAll, find, on(event), proxy(bind), attr(), height(), parseJSON, prependTo */
/* documented in case we can give zepto or ender a try (to shrink footprint). or maybe a custom build */

(function($){
  window.impaq = $.extend({}, window.impaq, {
    $: $,
    me: {
      config: {
        route: '',
        // iframe_src: '//localhost:3000'
        iframe_src: '//impaqme.herokuapp.com'
      },
      widgets: []
    }
  });

  var Widget = function(options){
    $.extend(this, options);

    var html = this.compile();
    this.iframe = $(html).replaceAll(this.placeholder).find('iframe')[0];
    $(this.iframe).on('load', $.proxy(this.wireUpCommunication, this));
    if(this.config && this.config.route === "banner"){
      $(this.iframe).on('load', $.proxy(this.bindScroll, this));
    }
  };

  Widget.prototype = {
    template: function(data){
      return '<div class="impaq-me-widget"><iframe src="'+ data.iframe_src +'?article_url='+ data.article_url +'&article_title='+ data.article_title +'#'+ data.route +'" style="width:100%; border:0;"></iframe></div>';
    },

    templateData: function(){
      return $.extend({}, impaq.me.config, this.config, {
        article_url: encodeURIComponent(this.articleURL()),
        article_title: encodeURIComponent(this.articleTitle())
      });
    },
    articleURL: function(){
      return this.placeholder.data('url') || $('link[rel=canonical]').attr('href') || window.location;
    },
    articleTitle: function(){
      return document.title;
    },
    compile: function(){
      return this.template(this.templateData());
    },
    resize: function(height){
      return $(this.iframe).height(height);
    },
    remove: function(){
      return this.iframe.parentNode.removeChild(this.iframe);
    },
    respondToChild: function(data){
      if(data.action === "close") {
        this.remove();
      } else {
        this.resize(data.args.height);
      }
    },
    minimizeChild: function(){
      $(window).unbind("scroll", this.minimizeChild);
      this.iframe.contentWindow.postMessage(JSON.stringify({widget_id: this.id, action: "minimize"}), this.iframe.src);
    },
    bindScroll: function(event){
      $(window).scroll($.proxy(this.minimizeChild, this));
    },
    wireUpCommunication: function(e){
      this.iframe.contentWindow.postMessage(JSON.stringify({widget_id: this.id, action: "initialize"}), this.iframe.src);
    }
  };

  $(window).on('message', function(e){
    // console.log("message received", e);
    var data = $.parseJSON(e.originalEvent.data);
    impaq.me.widgets[data.widget_id].respondToChild(data);
  });

  $('.impaq-me-placeholder').each(function(id, placeholder){
    impaq.me.widgets[id] = new Widget({
      id: id,
      placeholder: $(placeholder)
    });
  });

  if(window.location.search.match(/shared_via_impaq_me=/)) {
    var widget = new Widget({
      id: impaq.me.widgets.length,
      placeholder: $('<div>').prependTo('body'),
      config: { route: "banner" }
    });
    impaq.me.widgets.push(widget);
  }

})(jQuery.noConflict(true));
