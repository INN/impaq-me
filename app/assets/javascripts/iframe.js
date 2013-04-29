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
    console.log(URI(location).query(true).uri);
    data.url = URI(location).query(true).uri;
  });

  $("#share input").on('blur', function(){
    var url = $("#tweet-button").uri().query(true).url;
    var tweet = $(this).val() + " " + url;
    $("#tweet-button").uri().query(function(data){
      console.log(tweet);
      data.text = tweet;
    });
  });
});
