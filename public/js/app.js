window.twttr = (t = { _e: [], ready: function(f){ t._e.push(f); } });

twttr.ready(function(){
  console.log("twitter loaded");
  twttr.events.bind('tweet', function(event){
    console.log("tweeted");
    $.post(
      "/shares",
      {
        share: {
          campaign_id: 1,
          share_method: 'twitter',
          message: "hardcoded message"
        }
      },
      function(data, textStatus, jqXHR){
        console.log(textStatus);
        console.log(data);
        console.log(jqXHR);
      }
    );
  });
});
