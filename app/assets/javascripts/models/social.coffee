window.app.models.Social = class Social extends Backbone.Model
  initialize: ->
    @listenTo app.events,
      "share:twitter": @onTweet
      "share:facebook": @onLike
      "share:email": @onEmail

  onTweet: =>
    app.services.Share.recordTweet @get("campaign_id"), @get("article_url")
    app.services.Analytics.trackTweet @get("article_url")

  onLike: =>
    app.services.Share.recordLike @get("campaign_id"), @get("article_url")
    app.services.Analytics.trackLike @get("article_url")

  onEmail: =>
    app.services.Share.recordEmail @get("campaign_id"), @get("article_url")
    app.services.Analytics.trackEmail @get("article_url")
