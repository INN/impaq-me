window.twttr = (t = { _e: [], ready: function(f){ t._e.push(f); } });

twttr.ready(function(){
  console.log("twitter sdk loaded");
  twttr.events.bind('tweet', function(event){
    console.log("tweet event", event);
    $.post(
      "/shares",
      {
        share: {
          campaign_id: 1,
          share_method: 'twitter',
          testimonial: $("#share input").val()
        }
      },
      function(data, textStatus, jqXHR){
        console.log("tweet recorded", textStatus, data, jqXHR);
      }
    );
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
