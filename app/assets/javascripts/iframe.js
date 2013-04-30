twttr.ready(function(){
  twttr.events.bind('tweet', function(event){
    console.info("tweet event", event);
    app.services.Share.record_tweet(impaqme.share);
  });
});

fb.ready(function(){
  FB.Event.subscribe('edge.create', function(response) {
    console.info("fb like event", response);
  });
});

jQuery(function($){

  $('#share input').on('blur', function(e) {
    impaqme.share.testimonial = $(this).val();
  });

  $('#share .twitter').on('click', function(e) {
    $(this).uri().query(function(data){
      data.text = impaqme.share.testimonial;
      data.url = impaqme.share.article_url;
    });
  });

  $('#share .facebook').on('click', function(e) {
    FB.ui(
      {
      method: 'feed',
      link: impaqme.share.article_url
    },
    function(response) {
      if (response && response.post_id) {
        alert('Post was published.');
      } else {
        alert('Post was not published.');
      }
    }
    );
    e.preventDefault();
  });

});
