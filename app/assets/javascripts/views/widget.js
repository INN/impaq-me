window.app.views.Widget = Backbone.View.extend({

  initialize: function(options){
    _.bindAll(this);

    this.on('like', function(){ this.trigger('share'); }, this);
    this.on('tweet', function(){ this.trigger('share'); }, this);

    this.on('like', _.partial(this.recordShare, 'facebook', impaqme.campaign_id));
    this.on('tweet', _.partial(this.recordShare, 'twitter', impaqme.campaign_id));

    this.on('share', this.open);
  },

  recordShare: function(channel, campaign_id){
    app.services.Share.record(channel, campaign_id);
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
    this.views = $.extend({}, {
      header: new app.views.WidgetHeader().render(),
      share:  new app.views.Share().render(),
      body:   new app.views.WidgetBody({parent: this}).render()
    });

    this.$el.empty()
      .append(this.views.header.el)
      .append(this.views.share.el)
      .append(this.views.body.el);
    return this;
  }
});
