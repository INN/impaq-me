window.app.services.Share = {
  record: function(channel, campaign_id) {
    return $.post("/shares", {
      share: {
        campaign_id: campaign_id,
        channel: channel
      }
    });
  }
};
