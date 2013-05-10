window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
    click: "expandWidget"
  },

  initialize: function(options){
    _.bindAll(this);
    this.on('like', _.partial(this.share, 'facebook', impaqme.campaign_id));
    this.on('tweet', _.partial(this.share, 'twitter', impaqme.campaign_id));
  },

  share: function(channel, campaign_id){
    app.services.Share.record(channel, campaign_id);
    app.views.widget.open();
  },

  expandWidget: function(){
    app.views.widget.open();
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
