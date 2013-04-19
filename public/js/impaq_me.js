(function($){

  //FIXME: shouldn't alter client's jquery env
  $.ajaxSetup({
      cache: true
  });

  // load twitter and facebook SDKs
  // if(!$("#twitter-wjs").size())
  var twitter = $.getScript("//platform.twitter.com/widgets.js")
  // if(!$("#facebook-jssdk").size())
  var facebook = $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");


  // insert buttons
  $('body').append('<a href="https://twitter.com/share" class="twitter-share-button" data-lang="en">Tweet</a>');
  $('body').append('<div class="fb-like" data-width="90" data-layout="button_count"></div>');

  twitter.done(function(){
    twttr.widgets.load();
  });
  facebook.done(function(){
    FB.XFBML.parse();
  });

})(jQuery);
