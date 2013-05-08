(function($, _){
  window.impaq = $.extend({}, window.impaq, {
    $: $,
    _: _,
    me: {
      config: {
        route: '',
        iframe_src: '//localhost:3000'
      },
      widgets: []
    }
  });


  var Widget = function(options){
    $.extend(this, options);

    var html = this.compile();
    this.iframe = $(html).replaceAll(this.placeholder).find('iframe')[0];
    $(this.iframe).on('load', _.bind(this.wireUpCommunication, this));
  };

  Widget.prototype = {
    template: impaq.JST['app/templates/widget.us'],

    templateData: function(){
      return $.extend({}, impaq.me.config, this.config, { article_url: this.articleURL() });
    },
    articleURL: function(){
      return this.placeholder.data('url') || $('link[rel=canonical]').attr('href') || window.location;
    },
    compile: function(){
      return this.template(this.templateData());
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
    impaq.me.widgets[id] = new Widget({
      id: id,
      placeholder: $(placeholder)
    });
  });

})(jQuery.noConflict(true), _);//.noConflict());
