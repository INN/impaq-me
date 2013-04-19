(function($){
  window.impaq_me = $.extend({}, window.impaq_me, {

    init: function(){
            impaq_me.button = $("<button>ImpaqMe</button>").appendTo('body').click(impaq_me.step1);
          },

    preload_sdks: function(){
                    //FIXME: shouldn't alter client's jquery env
                    $.ajaxSetup({
                      cache: true
                    });

                    // load twitter and facebook SDKs
                    //FIXME ensure SDK only loaded once: if(!$("#twitter-wjs").size())
                    impaq_me.twitter = $.getScript("//platform.twitter.com/widgets.js");
                    //FIXME ensure SDK only loaded once: if(!$("#facebook-jssdk").size())
                    impaq_me.facebook = $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");
                  },

    step1: function(){
            $('body').append('<a href="https://twitter.com/share" class="twitter-share-button" data-lang="en">Tweet</a>');
            $('body').append('<div class="fb-like" data-width="90" data-layout="button_count"></div>');

            impaq_me.twitter.done(function(){
              twttr.widgets.load();
            });
            impaq_me.facebook.done(function(){
              FB.XFBML.parse();
            });
          }
  });


  impaq_me.init();
  impaq_me.preload_sdks();


})(jQuery);
