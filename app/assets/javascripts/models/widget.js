window.app.models.Widget = Backbone.Model.extend({
  recordTweet: function(){
    app.services.Share.record('twitter', impaqme.campaign_id);
    //TODO call sync()
  },
  recordLike: function(){
    app.services.Share.record('facebook', impaqme.campaign_id);
    //TODO call sync()
  },
  recordEmail: function(){
    app.services.Share.record('email', impaqme.campaign_id);
    //TODO call sync()
  }
});
