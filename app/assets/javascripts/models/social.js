window.app.models.Social = Backbone.Model.extend({
  initialize: function(){
    _.bindAll(this);

    this.listenTo(app.events, {
      'share:twitter':  this.onTweet,
      'share:facebook': this.onLike,
      'share:email':    this.onEmail
    });
  },

  onTweet: function(){
    app.services.Share.recordTweet(this.get('campaign_id'), this.get('article_url'));
    app.services.Analytics.trackTweet(this.get('article_url'));
  },
  onLike: function(){
    app.services.Share.recordLike(this.get('campaign_id'), this.get('article_url'));
    app.services.Analytics.trackLike(this.get('article_url'));
  },
  onEmail: function(){
    app.services.Share.recordEmail(this.get('campaign_id'), this.get('article_url'));
    app.services.Analytics.trackEmail(this.get('article_url'));
  }

});
