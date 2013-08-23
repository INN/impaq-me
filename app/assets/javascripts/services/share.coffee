window.app.services.Share = class Share
  @record: (channel, campaign_id, article_url) ->
    $.post "/shares",
      share:
        campaign_id: campaign_id
        article_url: article_url
        channel: channel

  @recordTweet: _(Share.record).partial("twitter")
  @recordLike: _(Share.record).partial("facebook")
  @recordEmail: _(Share.record).partial("email")
