window.twttr = (t = { _e: [], ready: function(f){ t._e.push(f); } });

twttr.ready(function(){
  console.log("twitter sdk loaded");
  twttr.events.bind('tweet', function(event){
    console.log("twitter tweet event", event);
    $.post(
      "http://impaq-backend.herokuapp.com/shares",
      {
        campaign_id: 1,
        share_method: 'twitter',
        message: "hardcoded message"
      },
      function(data, textStatus, jqXHR){
        console.log("tweet recorded:", textStatus, data, jqXHR);
      }
    );
  });
});

