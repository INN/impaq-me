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
          message: "hardcoded message"
        }
      },
      function(data, textStatus, jqXHR){
        console.log("tweet recorded", textStatus, data, jqXHR);
      }
    );
  });
});

jQuery(function($){
  $.getJSON("/campaign_meter?campaign_id=1", function(data, status, jqXHR){
    var progress = Math.min(data.total / data.goal, 1) * 100;
    $("#dollars_raised").text(data.total);
    $("#progress").css('width', progress+"%");
  });
});
