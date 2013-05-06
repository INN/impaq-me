window.app.views.Share = Backbone.View.extend({
  id: 'share',
  template: JST['share'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});

twttr.ready(function(){
  twttr.events.bind('tweet', function(event){
    console.info("tweet event", event);
    app.services.Share.record_tweet(impaqme.campaign_id);
    app.router.navigate('shared', {trigger:true});
  });
});

fb.ready(function(){
  FB.Event.subscribe('edge.create', function(response) {
    console.info("fb like event", response);
    app.services.Share.record_like(impaqme.campaign_id);
    app.router.navigate('shared', {trigger:true});
  });
});
