(function($, _){
  window.impaq = $.extend({}, window.impaq, {
    $: $,
    _: _,
    me: {
      config: {
        iframe_src: '//localhost:3000'
      },
      widgets: []
    }
  });


  var Widget = function(id, placeholder){
    // if(! this instanceof Widget) return new Widget(placeholder);

    this.placeholder = placeholder;
    this.id = id;

    var data = $.extend({}, impaq.me.config, { article_url: this.articleURL() });
    var html = this.compile(data);

    this.iframe = $(html).replaceAll(this.placeholder).find('iframe')[0];

    $(this.iframe).on('load', _.bind(this.wireUpCommunication, this));
  };

  Widget.prototype = {
    template: impaq.JST['app/templates/widget.us'],

    articleURL: function(){
      return this.placeholder.data('url') || $('link[rel=canonical]').attr('href') || window.location;
    },
    compile: function(data){
      return this.template(data);
    },
    resize: function(height){
      $(this.iframe).height(height);
    },
    wireUpCommunication: function(e){
      console.log("iframe loaded", e);
      this.iframe.contentWindow.postMessage(JSON.stringify({widget_id: this.id}), this.iframe.src);
    }
  };

  $(window).on('message', function(e){
    console.log("message received", e);
    var data = $.parseJSON(e.originalEvent.data);

    impaq.me.widgets[data.widget_id].resize(data.height);
  });

  $('.impaq-me-placeholder').each(function(id, placeholder){
    impaq.me.widgets[id] = new Widget(id, $(placeholder));
  });

})(jQuery.noConflict(true), _);//.noConflict());
