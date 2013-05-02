twttr.ready(function(){
  twttr.events.bind('tweet', function(event){
    console.info("tweet event", event);
    app.services.Share.record_tweet(impaqme.share);
  });
});

fb.ready(function(){
  FB.Event.subscribe('edge.create', function(response) {
    console.info("fb like event", response);
    app.services.Share.record_like(impaqme.share);
  });
});

jQuery(function($){

});
