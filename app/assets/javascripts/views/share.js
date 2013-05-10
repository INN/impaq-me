window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
    click: "toggle"
  },

  initialize: function(options){
    _.bindAll(this);
    this.on('like', _.partial(this.share, 'facebook', impaqme.campaign_id));
    this.on('tweet', _.partial(this.share, 'twitter', impaqme.campaign_id));
  },

  share: function(channel, campaign_id){
    app.services.Share.record(channel, campaign_id);
    app.views.widget_body.open();
  },

  toggle: function(){
    app.views.widget_body.toggle();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});

twttr.ready(function(){
  twttr.events.bind('tweet', function(event){
    app.views.share.trigger('tweet');
  });
});

fb.ready(function(){
  FB.Event.subscribe('edge.create', function(response) {
    app.views.share.trigger('like');
  });
});
