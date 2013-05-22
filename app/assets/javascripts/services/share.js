window.app.services.Share = {
  record: function(channel, campaign_id, article_url) {
    return $.post("/shares", {
      share: {
        campaign_id: campaign_id,
        article_url: article_url,
        channel: channel
      }
    });
  }
};

_(app.services.Share).extend({
  recordTweet: _.partial(app.services.Share.record, 'twitter'),
  recordLike:  _.partial(app.services.Share.record, 'facebook'),
  recordEmail: _.partial(app.services.Share.record, 'email')
});
