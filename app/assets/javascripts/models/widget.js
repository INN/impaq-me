window.app.models.Widget = Backbone.Model.extend({
  recordTweet: function(){
    app.services.Share.record('twitter');
  },
  recordLike: function(){
    app.services.Share.record('facebook');
  },
  recordEmail: function(){
    app.services.Share.record('email');
  }
});
