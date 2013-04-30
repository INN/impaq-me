twttr.ready(function(){
  console.info("twitter sdk loaded");
  twttr.events.bind('tweet', function(event){
    console.info("tweet event", event);
    app.services.Share.record_tweet(1, impaqme.share.testimonial);
  });
});

window.impaqme = {
  share: {
    testimonial: "",
    article_url: URI(location).query(true).uri || location
  }
};

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

});
