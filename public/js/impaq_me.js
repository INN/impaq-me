(function($){

  // to parse/insert new twitter/fb buttons after the SDKs have loaded, call twttr.widgets.load(); and FB.XFBML.parse();

  // insert twitter tweet button
  $('body').append('<a href="https://twitter.com/share" class="twitter-share-button" data-lang="en">Tweet</a>');
  // insert facebook 'like' button
  $('body').append('<div class="fb-like" data-width="90" data-layout="button_count"></div>');

  // load twitter and facebook SDKs
  $('body').append('<script>(function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs"));</script>');
  $('body').append('<script>(function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//connect.facebook.net/en_US/all.js#xfbml=1";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","facebook-jssdk"));</script>');

})(jQuery);
