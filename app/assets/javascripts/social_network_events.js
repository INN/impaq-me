
// async 'ready' handlers
window.twttr = (t = { _e: [], ready: function(f){ t._e.push(f); } });
window.fb    = (b = { _e: [], ready: function(f){ b._e.push(f); } });

// facebook doesn't have a multi-handler 'ready' event, so we built one
window.fbAsyncInit = function() {
  fb.ready = function(f){ f(); };
  _.invoke(fb._e, 'call');
};

fb.ready(function(){
  FB.init({
    appId: '598072260211923',
    xfbml: true
  });
});


twttr.ready(function(){
  twttr.events.bind('tweet', function(event){
    app.models.widget.set('tweeted', true).recordTweet();
  });
});

fb.ready(function(){
  FB.Event.subscribe('edge.create', function(response) {
    app.models.widget.set('liked', true).recordLike();
  });
});
