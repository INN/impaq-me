window.twttr = (t = { _e: [], ready: function(f){ t._e.push(f); } });

twttr.ready(function(){
  twttr.events.bind('tweet', function(event){
    $.post(
      "http://impaq-backend.herokuapp.com/shares",
      {
        campaign_id: 1,
        share_method: 'twitter',
        message: "hardcoded message"
      },
      function(data, textStatus, jqXHR){
        console.log(textStatus);
        console.log(data);
        console.log(jqXHR);
      }
    );
  });
});
