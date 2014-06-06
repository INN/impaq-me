window.app.models.Social = class Social extends Backbone.Model
  initialize: ->
    @listenTo app.events,
      "share:twitter": @onTweet
      "share:facebook": @onLike
      "share:email": @onEmail

  onTweet: =>
    app.services.Share.recordTweet @get("campaign_id"), @get("article_url")
    app.services.Analytics.trackTweet @get("article_url")
    app.services.Analytics.trackEvent "twitter", "tweet", "twitter_button", `undefined`, true

  onLike: =>
    app.services.Share.recordLike @get("campaign_id"), @get("article_url")
    app.services.Analytics.trackLike @get("article_url")
    app.services.Analytics.trackEvent "facebook", "like", "facebook_button", `undefined`, true

  onEmail: =>
    app.services.Share.recordEmail @get("campaign_id"), @get("article_url")
    app.services.Analytics.trackEmail @get("article_url")
    app.services.Analytics.trackEvent "email", "send", "email_button", `undefined`, true
