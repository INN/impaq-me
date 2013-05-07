(function($, _){
  $.extend(window.Impaq, {$:$, _:_});

  $.extend(window.Impaq, {
    me: {

      config: {
        button_text: 'Donate by Sharing',
        iframe_src: '//localhost:3000'
      },

      init: function(){
        var marker = $(".impaq-me-button");

        var data = $.extend({}, this.config, { article_url: this.articleURL(marker) });

        this.iframe = $(this.compileWidget(data)).replaceAll(marker).find('iframe')[0];
      },

      compileWidget: function(data){
        return Impaq.JST['app/templates/widget.us'](data);
      },

      articleURL: function(marker){
        return marker.data('url') || $('link[rel=canonical]').attr('href') || location;
      },

      toggleWidget: function(){
        console.log(this);
        $(this.iframe).toggle();
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

  $(".impaq-me-widget button").on('click', Impaq.me.toggleWidget);
  $(window).on('message', Impaq.me.resizeIframe);
  $(Impaq.me.iframe).on('load', Impaq.me.wireUpIframeCommunication);

})(jQuery.noConflict(true), _);//.noConflict());
