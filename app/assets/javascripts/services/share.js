window.app.services.Share = {
  record_share: function(share) {
    return $.post(
      "/shares",
      {
        share: {
          campaign_id: share.campaign_id,
          share_method: share.channel
        }
      },
      function(data, textStatus, jqXHR){
        console.info(share.channel + " share recorded", textStatus, data, jqXHR);
      }
    );
  },

  record_tweet: function(share) {
    this.record_share(_.extend(share, {channel: 'twitter'}));
  },

  record_like: function(share) {
    this.record_share(_.extend(share, {channel: 'facebook'}));
  },
};
