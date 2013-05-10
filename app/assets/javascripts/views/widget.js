window.app.views.Widget = Backbone.View.extend({

  initialize: function(options){
    _.bindAll(this);

    this.views = $.extend({}, {
      header: new app.views.WidgetHeader().render(),
      share:  new app.views.Share().render(),
      body:   new app.views.WidgetBody().render()
    });

    this.on('like', _.partial(this.share, 'facebook', impaqme.campaign_id));
    this.on('tweet', _.partial(this.share, 'twitter', impaqme.campaign_id));
  },

  share: function(channel, campaign_id){
    app.services.Share.record(channel, campaign_id);
    this.open();
    this.views.body.thanks();
  },

  open: function(){
    this.views.body.$el.slideDown();
    return this;
  },

  close: function(){
    this.views.body.$el.slideUp();
    return this;
  },

  render: function(){
    this.$el.empty()
      .append(this.views.header.el)
      .append(this.views.share.el)
      .append(this.views.body.el);
    return this;
  }
});
