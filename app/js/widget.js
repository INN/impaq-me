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

        var data = $.extend({}, this.config, {
          article_url: this.articleURL(marker)
        });

        $(this.compileWidget(data)).replaceAll(marker);
      },

      compileWidget: function(data){
        return Impaq.JST['app/templates/widget.us'](data);
      },

      articleURL: function(marker){
        return marker.data('url') || $('link[rel=canonical]').attr('href') || location;
      }
    }
  });


  Impaq.me.init();
  $("button").on('click', function() {
    $('.impaq-me-widget iframe').toggle();
  });

})(jQuery.noConflict(true), _);//.noConflict());
