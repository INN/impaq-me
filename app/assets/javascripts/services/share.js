window.app.services.Share = (function() {
  var record_share = function(channel, campaign_id) {
    return $.post("/shares", {
        share: {
          campaign_id: campaign_id,
          share_method: channel
        }
      },
      function(data, textStatus, jqXHR){
        console.info(channel + " share recorded", textStatus, data, jqXHR);
      }
    );
  };

  return {
    record_tweet: _.partial(record_share, 'twitter'),
    record_like:  _.partial(record_share, 'facebook')
  };
})();
