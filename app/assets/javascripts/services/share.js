window.app.services.Share = {
  record: function(channel) {
    return $.post("/shares", {
      share: {
        campaign_id: app.models.widget.get('campaign_id'),
        article_url: app.models.widget.get('article_url'),
        channel: channel
      }
    });
  }
};
