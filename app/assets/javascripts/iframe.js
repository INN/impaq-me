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
          message: $("#share input").val()
        }
      },
      function(data, textStatus, jqXHR){
        console.log("tweet recorded", textStatus, data, jqXHR);
      }
    );
  });
});

jQuery(function($){
  $("#tweet-button").uri().query(function(data){
    data.url = URI().query(true).uri;
  });

  $("#share input").on('blur', function(){
    var tweet = $(this).val();
    $("#tweet-button").uri().query(function(data){
      data.text = tweet;
    });
  });
});
