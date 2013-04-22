//FIXME: currently depends on jQuery being loaded in host page
(function($){
  window.impaq_me = $.extend({}, window.impaq_me, {

    init: function(){
            this.button = $("<button>ImpaqMe</button>").appendTo('body');
            this.button.click($.proxy(this.step1, this));
          },

    preload_sdks: function(){
                    //FIXME: shouldn't alter client's jquery env
                    $.ajaxSetup({
                      cache: true
                    });

                    // load twitter and facebook SDKs
                    //FIXME ensure SDK only loaded once: if(!$("#twitter-wjs").size())
                    this.twitter = $.getScript("//platform.twitter.com/widgets.js");
                    //FIXME ensure SDK only loaded once: if(!$("#facebook-jssdk").size())
                    this.facebook = $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");
                  },

    step1: function(){
            $('body').append('<a href="https://twitter.com/share" class="twitter-share-button" data-lang="en">Tweet</a>');
            $('body').append('<div class="fb-like" data-width="90" data-layout="button_count"></div>');

            this.twitter.done(function(){
              twttr.widgets.load();
            });
            this.facebook.done(function(){
              FB.XFBML.parse();
            });
          }
  });


  impaq_me.init();
  impaq_me.preload_sdks();


})(jQuery);


// ImpaqMe.registerShareService({
//   name: added to .services
//   sdk: 
//     string of script to load with getScript, (promise() returned as .services.<name>.sdk)
//     or
//     function to be executed, context set as ImpaqMe
//   step1
//     function to be executed when the 
