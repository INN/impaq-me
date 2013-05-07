(function($, _){
  $.extend(window.Impaq, {$:$, _:_});

  $.extend(window.Impaq, {
    me: {

      config: {
        iframe_src: '//localhost:3000'
      },

      init: function(){
        var placeholders = $(".impaq-me-button");

        var data = $.extend({}, this.config, { article_url: this.articleURL(placeholders) });

        this.iframe = $(this.compileWidget(data)).replaceAll(placeholders).find('iframe')[0];
      },

      compileWidget: function(data){
        return Impaq.JST['app/templates/widget.us'](data);
      },

      articleURL: function(placeholder){
        return placeholder.data('url') || $('link[rel=canonical]').attr('href') || location;
      },

      resizeIframe: function(e){
        console.log("message received", e);
        $(this.iframe).height(e.originalEvent.data);
      },

      wireUpIframeCommunication: function(e){
        console.log("iframe loaded", e);
        this.iframe.contentWindow.postMessage("wire me up", this.iframe.src);
      }
    }
  });

  _.bindAll(Impaq.me);

  Impaq.me.init();

  $(window).on('message', Impaq.me.resizeIframe);
  $(Impaq.me.iframe).on('load', Impaq.me.wireUpIframeCommunication);

})(jQuery.noConflict(true), _);//.noConflict());
