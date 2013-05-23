window.app.views.BannerClose = Backbone.View.extend({
  events: {
    click: "close",
  },

  initialize: function(options){
    _.bindAll(this);
  },

  close: function(){
    app.views.window.closeParent();
    app.services.Analytics.trackEvent('banner', 'close', 'close_button', undefined, true);
  },

  render: function(){
    this.$el.html('<button class="close"><i class="icon-remove-sign" title="close"></i></button>');
    return this;
  }
});
